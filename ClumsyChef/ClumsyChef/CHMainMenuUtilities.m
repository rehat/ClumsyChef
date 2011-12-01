//
//  CHMainMenuUtilities.m
//  ClumsyChef
//
//  Created by Tong on 24/11/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHMainMenuUtilities.h"
#import "CHMenuTransitionScene.h"
#import "CHMenuButton.h"


ccTime const kAnimDuration = 0.3f;

CCMenu* CHMenuMakeBackButton(CGPoint position, id target, SEL selector)
{
	CCMenuItemImage *back = [CHMenuButton itemFromImageName:@"menu-backButton" 
													  sound:CHSoundButtonBack
													 target:target
												   selector:selector];
	CCMenu *button = [CCMenu menuWithItems:back, nil];
	button.anchorPoint = CGPointZero;
	button.position = CGPointZero;
	[back setPositionSharp:position];
	
	return button;
}

void CHMenuPushScene(CCScene *scene)
{
	CHMenuTransitionScene *s = [CHMenuTransitionScene transitionWithDuration:kAnimDuration scene:scene];
	[[CCDirector sharedDirector] pushScene:s];
}

void CHMenuPopScene()
{
	[[CCDirector sharedDirector] popSceneWithTransition:[CHMenuTransitionSceneBack class] 
											   duration:kAnimDuration];
}