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


@implementation CHGameScene
{
	CHBackgroundLayer	*_bgLayer;
	CHGameLayer			*_gameLayer;
}

- (id)init
{
	if (self = [super init])
	{
		_bgLayer = [[CHBackgroundLayer alloc] init];
		_gameLayer = [[CHGameLayer alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[_bgLayer release];
	[_gameLayer release];
	[super dealloc];
}

@end