//
//  CHCreditLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHCreditLayer.h"


@implementation CHCreditLayer

- (id)init
{
	if (self = [super init])
	{
		CCSprite *bg = [CCSprite spriteWithFile:@"credits-background.png"];
		[bg setPositionSharp:CHGetWinCenterPoint()];
		[self addChild:bg];
		
		CCMenuItemImage *back = [CCMenuItemImage itemFromNormalImage:@"menu-backButton.png" 
													   selectedImage:@"menu-backButton-high.png" 
															  target:self 
															selector:@selector(backButtonPressed:)];
		CCMenu *button = [CCMenu menuWithItems:back, nil];
		button.anchorPoint = CGPointZero;
		button.position = CGPointZero;
		[back setPositionSharp:ccp(CHGetHalfWinWidth(), 51)];
		[self addChild:button];
	}
	return self;
}

- (void)backButtonPressed:(id)sender
{
	
}

@end
