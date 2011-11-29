//
//  CHSplashImageLayer.m
//  ClumsyChef
//
//  Created by Tong on 29/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHSplashImageLayer.h"
#import "CHMainMenuLayer.h"

@implementation CHSplashImageLayer

- (id)init
{
	if (self = [super init])
	{
		NSString *filename;
		if ([[UIScreen mainScreen] scale] > 1)
		{
			filename = @"Default@2x.png";
		}
		else
		{
			filename = @"Default.png";
		}
		
		CCSprite *splash = [CCSprite spriteWithFile:filename];
		[splash setContentSize:CHGetWinSize()];
		[splash setPosition:CHGetWinCenterPoint()];
		
		[self addChild:splash];
	}
	return self;
}

- (void)onEnter
{
	[super onEnter];
	CCTransitionZoomFlipX *trans = [CCTransitionZoomFlipX transitionWithDuration:0.4f 
																		   scene:[CHMainMenuLayer node]];
	[[CCDirector sharedDirector] replaceScene:trans];
}

@end
