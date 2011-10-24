//
//  CHTitleLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHTitleLayer.h"

@implementation CHTitleLayer
{
	// Instance variables
}

+ (CCScene *)scene
{
	CHTitleLayer *layer = [CHTitleLayer node];
	CCScene *scene = [CCScene node];
	[scene addChild:layer];
	return scene;
}

@end
