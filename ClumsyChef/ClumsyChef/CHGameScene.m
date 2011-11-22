//
//  CHGameScene.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHGameScene.h"
#import "CHBackgroundLayer.h"
#import "CHGameLayer.h"
#import "CHGameLibrary.h"
#import "CHGameWinLayer.h"
#import "CHGameLoseLayer.h"

@implementation CHGameScene
{
	CCLabelBMFont	*_debugLabel;
	CHGameLayer		*_gameLayer;
    NSUInteger		_levelIndex;
}

#pragma mark - 
#pragma mark Constructor and destructor

- (id)initWithLevelIndex:(NSUInteger)levelIndex
{
	if (self = [super init])
	{
		_levelIndex = levelIndex;
		_gameLayer = [CHGameLayer nodeWithLevelIndex:levelIndex];
        [self addChild:_gameLayer z:0];
		
		_debugLabel = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:@"font-testFont.fnt"] autorelease];
		[_debugLabel setColor:ccGREEN];
		_debugLabel.anchorPoint = ccp(1, 1);
		_debugLabel.position = CHGetWinPointTR(20, 20);
		[self addChild:_debugLabel];
	}
	return self;
}

+ (id)nodeWithLevelIndex:(NSUInteger)levelIndex
{
	return [[[self alloc] initWithLevelIndex:levelIndex] autorelease];
}

+ (id)node
{
	NSAssert(NO, @"+node no longer used, use +nodeWithLevelIndex");
	return nil;
}

- (void)dealloc
{
	[super dealloc];
}

#pragma mark -
#pragma mark public API

- (void)setDebugMessage:(NSString *)format, ...
{
	va_list args;
	va_start(args, format);	
	NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
	va_end(args);

	[_debugLabel setString:msg];
	[msg release];
}

#pragma mark - 
#pragma mark Game Win/Game Lose

- (void)showWin:(NSInteger)score
{
    [self removeChild:_gameLayer cleanup:YES];
    CHGameWinLayer *winLayer = [CHGameWinLayer nodeWithMoneyAmount:score];
    [self addChild:winLayer];
}

-(void)showGameOver{
    [self removeChild:_gameLayer cleanup:YES];
    CHGameLoseLayer *loseLayer = [CHGameLoseLayer node];
    [self addChild:loseLayer];
}

#pragma mark -
#pragma mark Pause

- (void)pauseGame
{
	// Pause
	// Show menu
}


- (void)resumeGame
{
	
}

- (void)restartLevel
{
	NSUInteger levelIndex = _levelIndex;
	CCDirector *d = [CCDirector sharedDirector];
	[d popScene];
	[d pushScene:[CHGameScene nodeWithLevelIndex:levelIndex]];
}

- (BOOL)hasNextLevel
{
	NSUInteger numLevels = [[CHGameLibrary sharedGameLibrary] numberOfLevels];
	return (_levelIndex + 1 < numLevels);
}

- (void)loadNextLevel
{
	NSAssert([self hasNextLevel], @"No next level");
	NSUInteger next = _levelIndex + 1;
	CCDirector *d = [CCDirector sharedDirector];
	[d popScene];
	[d pushScene:[CHGameScene nodeWithLevelIndex:next]];
}

- (void)quitGame
{
	[[CCDirector sharedDirector] popScene];
}

@end
