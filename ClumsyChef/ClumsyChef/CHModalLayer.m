//
//  CHModalLayer.m
//  ClumsyChef
//
//  Created by Tong on 22/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHModalLayer.h"
#import "CHTouchBlockingLayer.h"

@implementation CHModalLayer

- (id)init
{
	if (self = [super init])
	{
		[self addChild:[CHTouchBlockingLayer node]];
	}
	return self;
}

- (void)showAsModalLayerInNode:(CCNode *)node
{
	[node addChild:self];
	// TODO: run like "pop-up" animation to show this layer
}

- (void)dismissModalLayer
{
	[self removeFromParentAndCleanup:YES];
}

@end
