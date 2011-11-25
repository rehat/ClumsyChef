//
//  CHMainMenuLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHMainMenuLayer.h"
#import "SimpleAudioEngine.h"

@implementation CHMainMenuLayer

- (id)init
{
	if (self = [super init])
	{
		CCSprite *bg = [CCSprite spriteWithFile:@"mainMenu-background.png"];
		[bg setPositionSharp:CHGetWinCenterPoint()];
		[self addChild:bg];
		
		// Menu button
		CCMenuItemImage *play = [CCMenuItemImage itemFromNormalImage:@"mainMenu-play.png" 
														selectedImage:@"mainMenu-play-high.png" 
															   target:self 
															 selector:@selector(playPressed:)];
		[play setPositionSharp:CHGetWinPointTL(240, 163)];
		
		CCMenuItemImage *highScores = [CCMenuItemImage itemFromNormalImage:@"mainMenu-highScores.png" 
													   selectedImage:@"mainMenu-highScores-high.png" 
															  target:self 
															selector:@selector(highScoresPressed:)];
		[highScores setPositionSharp:CHGetWinPointTL(240, 204)];
		
		CCMenuItemImage *credits = [CCMenuItemImage itemFromNormalImage:@"mainMenu-credits.png" 
													   selectedImage:@"mainMenu-credits-high.png" 
															  target:self 
															selector:@selector(creditsPressed:)];
		[credits setPositionSharp:CHGetWinPointTL(240, 245)];
		

		CCMenuItemImage *soundOff = [CCMenuItemImage itemFromNormalImage:@"mainMenu-soundOff.png" 
														   selectedImage:nil];
		CCMenuItemImage *soundOn = [CCMenuItemImage itemFromNormalImage:@"mainMenu-soundOn.png" 
														  selectedImage:nil];
		CCMenuItemToggle *toggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundPressed:) 
															  items:soundOn, soundOff, nil];
		[toggle setPositionSharp:ccp(289, 23)];
		
		CCMenu *menu = [CCMenu menuWithItems:play, highScores, credits, toggle, nil];
		menu.anchorPoint = CGPointZero;
		menu.position = CGPointZero;
		[self addChild:menu];
	}
	return self;
}

#pragma mark - 
#pragma mark UI events

- (void)playPressed:(id)sender
{
	
}

- (void)highScoresPressed:(id)sender
{
	
}

- (void)creditsPressed:(id)sender
{
	
}

- (void)soundPressed:(id)sender
{
	
}

@end