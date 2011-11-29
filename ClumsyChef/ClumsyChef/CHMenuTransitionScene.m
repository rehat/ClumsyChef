//
//  CHMenuTransitionScene.m
//  ClumsyChef
//
//  Created by Tong on 29/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHMenuTransitionScene.h"


@implementation CHMenuTransitionScene

- (void)onEnter
{
	[super onEnter];
	
	CGFloat distance = CHGetWinWidth() + 20;
	if ([self isReversed])
	{
		distance = -distance;
	}
	
	inScene_.anchorPoint = CGPointZero;
	inScene_.position = ccp(distance, 0);
	
	outScene_.anchorPoint = CGPointZero;
	outScene_.position = CGPointZero;
	
	CCMoveTo *inMove = [CCMoveBy actionWithDuration:duration_ position:ccp(-distance, 0)];
	CCMoveTo *outMove = [CCMoveBy actionWithDuration:duration_ position:ccp(-distance, 0)];

	[outScene_ runAction:[CCEaseInOut actionWithAction:outMove rate:3]];
	[inScene_ runAction:[CCSequence actions:
						 [CCEaseInOut actionWithAction:inMove rate:3],
						 [CCCallFunc actionWithTarget:self selector:@selector(finish)], nil]];

}

// Overriden by subclass
- (BOOL)isReversed
{
	return NO;
}

@end


@implementation CHMenuTransitionSceneBack

- (BOOL)isReversed
{
	return YES;
}

@end