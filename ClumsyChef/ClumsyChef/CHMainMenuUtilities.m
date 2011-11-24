//
//  CHMainMenuUtilities.m
//  ClumsyChef
//
//  Created by Tong on 24/11/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHMainMenuUtilities.h"

CCMenu* CHMenuMakeBackButton(CGPoint position, id target, SEL selector)
{
	CCMenuItemImage *back = [CCMenuItemImage itemFromNormalImage:@"menu-backButton.png" 
												   selectedImage:@"menu-backButton-high.png" 
														  target:target 
														selector:selector];
	CCMenu *button = [CCMenu menuWithItems:back, nil];
	button.anchorPoint = CGPointZero;
	button.position = CGPointZero;
	[back setPositionSharp:position];
	
	return button;
}