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

@implementation CHGameScene
{
	CCLabelBMFont *_debugLabel;

	CHBackgroundLayer	*_bgLayer;
	CHGameLayer			*_gameLayer;
}

#pragma mark - 
#pragma mark Constructor and destructor

- (id)init
{
	if (self = [super init])
	{
		_bgLayer = [CHBackgroundLayer node];
		_gameLayer = [CHGameLayer node];
		[self addChild:_bgLayer z:-1];
        [self addChild:_gameLayer z:0];
		
		_debugLabel = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:@"font-testFont.fnt"] autorelease];
		[_debugLabel setColor:ccGREEN];
		_debugLabel.anchorPoint = ccp(1, 1);
		_debugLabel.position = CHGetWinPointTR(20, 20);
		[self addChild:_debugLabel];
	}
	return self;
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

#pragma mark-
#pragma mark Game Layer

- (void)worldOffsetDidChange:(NSInteger)newOffset
{
	[self setDebugMessage:@"%d", newOffset];
}

- (void)chefDidReachBottom
{
	
}

#pragma mark -
#pragma mark Game Object Calls

- (void)addChefMoney:(NSInteger)amount
{
	
}

- (void)chefDidCollectRecipeItem:(CHRecipeItemID)itemID
{
	
}

- (void)deductChefLife:(NSInteger)numLife
{
	
}

#pragma mark - 
#pragma mark HUD calls

- (void)pauseGame
{
	
}

#pragma mark -
#pragma mark Pause

- (void)resumeGame
{
	
}

- (void)restartLevel
{
	
}

- (void)quitGame
{
	
}

@end
