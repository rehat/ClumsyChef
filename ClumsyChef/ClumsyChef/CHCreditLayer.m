//
//  CHCreditLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHCreditLayer.h"
#import "CHMainMenuUtilities.h"
#import "SimpleAudioEngine.h"


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
		
		CCMenuItem *item = [CCMenuItem itemWithTarget:self selector:@selector(playSound:)];
		[item setContentSize:CGSizeMake(180, 40)];
		[item setPositionSharp:ccp(CHGetHalfWinWidth(), 290)];
		CCMenu *menu = [CCMenu menuWithItems:item, nil];
		menu.anchorPoint = CGPointZero;
		menu.position = CGPointZero;
		[self addChild:menu];
	}
	return self;
}

- (void)backButtonPressed:(id)sender
{
	CHMenuPopScene();
}

- (void)playSound:(id)sender
{
	[[SimpleAudioEngine sharedEngine] playEffect:@"Comedy Boing.caf"];
}

@end
