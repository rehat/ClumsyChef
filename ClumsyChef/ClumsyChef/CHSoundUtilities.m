//
//  CHSoundUtilities.m
//  ClumsyChef
//
//  Created by Tong on 30/11/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHSoundUtilities.h"
#import "SimpleAudioEngine.h"

NSString* const CHSoundButtonPress = @"click1.wav";
NSString* const CHSoundButtonBack = @"back.wav";
NSString* const CHSoundButtonPopup = @"click2.wav";


static void playSound(NSString *name)
{
	SimpleAudioEngine *a = [SimpleAudioEngine sharedEngine];
	[a playEffect:name];
}

void CHSoundPlayButtonPress()
{
	playSound(@"click1.wav");
}

void CHSoundPlayButtonBack()
{
	playSound(@"back.wav");	
}

void CHSoundPlayButtonPopup()
{
	playSound(@"click2.wav");	
}