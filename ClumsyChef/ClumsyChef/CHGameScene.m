//
//  CHGameScene.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHGameScene.h"
#import "CHGameLayer.h"
#import "CHGameLibrary.h"
#import "CHGameWinLayer.h"
#import "CHGameLoseLayer.h"
#import "CHPauseLayer.h"


@implementation CHGameScene
{
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
        [self addChild:_gameLayer];
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
#pragma mark Game Win/Game Lose

- (void)showWin:(NSInteger)score
{
	[_gameLayer stopBackgroundMusic];
	_gameLayer.isPaused = YES;
	[[CHGameWinLayer nodeWithLevelIndex:_levelIndex moneyAmount:score] showAsModalLayerInNode:self];
}

- (void)showGameOver
{
	[_gameLayer stopBackgroundMusic];
    _gameLayer.isPaused = YES;
	[[CHGameLoseLayer node] showAsModalLayerInNode:self];
}

#pragma mark -
#pragma mark Pause

- (void)pauseGame
{
	_gameLayer.isPaused = YES;
	CHPauseLayer *p = [CHPauseLayer node];
	[p showAsModalLayerInNode:self];
}

- (void)resumeGame
{
	_gameLayer.isPaused = NO;
}

- (void)restartLevel
{
	[_gameLayer resetForLevelIndex:_levelIndex];
	_gameLayer.isPaused = NO;
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
	[_gameLayer resetForLevelIndex:next];
	_gameLayer.isPaused = NO;
}

- (void)quitGame
{
	[[CCDirector sharedDirector] popScene];
}

@end
