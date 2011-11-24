//
//  CHModalLayer.m
//  ClumsyChef
//
//  Created by Tong on 22/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHModalLayer.h"
#import "CHTouchBlockingLayer.h"

float const CHModalLayerDefaultDimOpacity = 0.6f;

@implementation CHModalLayer
{
}

- (id)initWithDimOpacity:(float)opacity
{
	if (self = [super init])
	{
		[self addChild:[CHTouchBlockingLayer node]];
		CCLayerColor *dimLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, opacity * 255)];
		[self addChild:dimLayer];
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
