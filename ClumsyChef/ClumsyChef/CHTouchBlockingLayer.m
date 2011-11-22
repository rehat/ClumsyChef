//
//  CHTouchBlockingLayer.m
//  ClumsyChef
//
//  Created by Tong on 22/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHTouchBlockingLayer.h"


@implementation CHTouchBlockingLayer

- (id)init
{
	if (self = [super init])
	{
		self.isTouchEnabled = YES;
		
		// Block touch events from delivering to the menus below it by setting it to the same priority
		// http://www.cocos2d-iphone.org/forum/topic/15228
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self 
														 priority:kCCMenuTouchPriority 
												  swallowsTouches:YES];
	}
	return self;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	// Claim the touch
	return YES;
}

@end
