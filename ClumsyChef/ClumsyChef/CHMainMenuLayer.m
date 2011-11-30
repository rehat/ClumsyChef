//
//  CHMainMenuLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHMainMenuLayer.h"
#import "SimpleAudioEngine.h"
#import "CHSelectLevelLayer.h"
#import "CHHighScoresLayer.h"
#import "CHCreditLayer.h"
#import "CHMainMenuUtilities.h"


@implementation CHMainMenuLayer
{
	CCMenuItemToggle *_soundToggle;
}

#pragma mark -
#pragma mark Private

- (void)updateSoundToggleButton
{
	SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
	_soundToggle.selectedIndex = (engine.mute? 1 : 0);
}

#pragma mark -
#pragma mark Constructor and destructor
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
		_soundToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundPressed:) 
															  items:soundOn, soundOff, nil];
		[_soundToggle setPositionSharp:ccp(289, 23)];
		
		CCMenu *menu = [CCMenu menuWithItems:play, highScores, credits, _soundToggle, nil];
		menu.anchorPoint = CGPointZero;
		menu.position = CGPointZero;
		[self updateSoundToggleButton];
		[self addChild:menu];
	}
	return self;
}

#pragma mark - 
#pragma mark UI events

- (void)onEnter
{
	[super onEnter];
	
	if (![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
	{
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"mainMenu.caf" loop:YES];
		[SimpleAudioEngine sharedEngine].backgroundMusicVolume = 0.4f;
	}
}

- (void)playPressed:(id)sender
{
	CHMenuPushScene([CHSelectLevelLayer node]);
}

- (void)highScoresPressed:(id)sender
{
	CHMenuPushScene([CHHighScoresLayer node]);	
}

- (void)creditsPressed:(id)sender
{
	CHMenuPushScene([CHCreditLayer node]);
}

- (void)soundPressed:(id)sender
{
	SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
	engine.mute = !engine.mute;
	[self updateSoundToggleButton];
}

@end