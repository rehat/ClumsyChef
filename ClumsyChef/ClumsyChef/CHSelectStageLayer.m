//
//  CHSelectStageLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHSelectStageLayer.h"

@implementation CHSelectStageLayer

+ (CCScene *)scene
{
	CHSelectStageLayer *layer = [CHSelectStageLayer node];
	CCScene *scene = [CCScene node];
	[scene addChild:layer];
	return scene;
}

@end
