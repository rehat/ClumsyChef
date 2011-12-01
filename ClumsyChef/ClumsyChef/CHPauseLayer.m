//
//  CHPauseLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHPauseLayer.h"
#import "CHGameScene.h"
#import "SimpleAudioEngine.h"
#import "CHGameScene.h"
#import "CHMenuButton.h"


@implementation CHPauseLayer
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

- (CHGameScene *)gameSceneParent
{
	CHGameScene *p = (CHGameScene *)self.parent;
	if ([p isKindOfClass:[CHGameScene class]])
		return p;
	return nil;
}

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
	if (self = [super initWithDimOpacity:CHModalLayerDefaultDimOpacity])
	{
		CCSprite *menuBG = [CCSprite spriteWithFile:@"pause-background.png"];
		[menuBG setPositionSharp:ccp(CHGetHalfWinWidth(), CHGetHalfWinHeight())];
		[self addChild:menuBG];
		
		CCMenuItemImage *resumeBtn = [CHMenuButton itemFromImageName:@"pause-resume"
															   sound:CHSoundButtonBack
															  target:self 
															selector:@selector(resumePressed:)];
		[resumeBtn setPositionSharp:ccp(106, 264)];
		
		CCMenuItemImage *restart = [CHMenuButton itemFromImageName:@"pause-restart" 
															 sound:CHSoundButtonPress
															target:self 
														  selector:@selector(restartPressed:)];
		[restart setPositionSharp:ccp(209, 264)];
		
		CCMenuItemImage *soundOn = [CCMenuItemImage itemFromNormalImage:@"pause-sound.png" 
														  selectedImage:@"pause-sound-high.png"];
		CCMenuItemImage *soundOff = [CCMenuItemImage itemFromNormalImage:@"pause-sound-off.png" 
														   selectedImage:@"pause-sound-off-high.png"];
		_soundToggle = [CCMenuItemToggle itemWithTarget:self 
											   selector:@selector(soundPressed:) 
												  items:soundOn, soundOff, nil];
		[_soundToggle setPositionSharp:ccp(106, 205)];
		
		CCMenuItemImage *quit = [CHMenuButton itemFromImageName:@"pause-quit" 
														  sound:CHSoundButtonPress
														 target:self 
													   selector:@selector(quitPressed:)];
		[quit setPositionSharp:ccp(209, 205)];
		
		CCMenu *menu = [CCMenu menuWithItems:resumeBtn, restart, _soundToggle, quit, nil];
		menu.anchorPoint = CGPointZero;
		menu.position = CGPointZero;
		
		[self updateSoundToggleButton];
		[self addChild:menu];
	}
	return self;
}


#pragma mark -
#pragma mark UI

- (void)resumePressed:(id)sender
{
	CHGameScene *p = [self gameSceneParent];
	[self dismissModalLayer];
	[p resumeGame];
}

- (void)restartPressed:(id)sender
{
	CHGameScene *p = [self gameSceneParent];
	[self dismissModalLayer];
	[p restartLevel];	
}

- (void)soundPressed:(id)sender
{
	SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
	engine.mute = !engine.mute;
	[self updateSoundToggleButton];
}

- (void)quitPressed:(id)sender
{
	CHGameScene *p = [self gameSceneParent];
	[self dismissModalLayer];
	[p quitGame];	
}

@end
