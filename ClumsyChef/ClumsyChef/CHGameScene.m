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
	CHBackgroundLayer	*_bgLayer;
	CHGameLayer			*_gameLayer;
}

#pragma mark - 
#pragma mark Constructor and destructor

- (id)init
{
	if (self = [super init])
	{
		//_bgLayer = [[CHBackgroundLayer alloc] init];
		_gameLayer = [[CHGameLayer alloc] init];
		[self addChild:_gameLayer];
	}
	return self;
}

- (void)dealloc
{
	
	[super dealloc];
}

#pragma mark -
#pragma mark Game Object Calls

- (void)addChefMoney:(NSInteger)amount
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

@end
