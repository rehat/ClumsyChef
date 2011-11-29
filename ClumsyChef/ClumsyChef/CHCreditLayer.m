//
//  CHCreditLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHCreditLayer.h"
#import "CHMainMenuUtilities.h"


@implementation CHCreditLayer

- (id)init
{
	if (self = [super init])
	{
		CCSprite *bg = [CCSprite spriteWithFile:@"credits-background.png"];
		[bg setPositionSharp:CHGetWinCenterPoint()];
		[self addChild:bg];
		
		CCMenu *button = CHMenuMakeBackButton(ccp(CHGetHalfWinWidth(), 51), self, @selector(backButtonPressed:));
		[self addChild:button];
	}
	return self;
}

- (void)backButtonPressed:(id)sender
{
	CHMenuPopScene();
}

@end
