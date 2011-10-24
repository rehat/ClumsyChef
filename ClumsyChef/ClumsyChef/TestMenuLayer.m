//
//  TestMenuLayer.m
//  ClumsyChef
//
//  Created by Tong on 23/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "TestMenuLayer.h"
#import "CHUtilities.h"
// ----------------------------------
// Add the scene/layer header files for each scene you want to test here
#import "CHBackgroundLayer.h"
#import "CHGameLayer.h"
#import "CHGameScene.h"

//-----------------------------------

@implementation TestMenuLayer

+ (CCScene *)scene
{
	TestMenuLayer *layer = [TestMenuLayer node];
	CCScene *scene = [CCScene node];
	[scene addChild:layer];
	return scene;
}

- (void)runScene:(CCScene *)scene
{
	[[CCDirector sharedDirector] pushScene:scene];
}

- (void)runLayer:(CCLayer *)layer
{
	// Wrap it with a scene
	CCScene *scene = [CCScene node];
	[scene addChild:layer];
	[self runScene:scene];
}

- (id)init
{
	if (self = [super initWithColor:cc4Hex(0x80c8ff) fadingTo:cc4Hex(0x0593ed)])
	{
		// Add the tests menu item here
		//-----------------------------------
		CCMenuItemFont *itemTest1 = [CCMenuItemFont itemFromString:@"Background Layer" block:^(id sender) {
			[self runLayer:[CHBackgroundLayer node]];
		}];
		
		CCMenuItemFont *itemTest2 = [CCMenuItemFont itemFromString:@"Game Layer" block:^(id sender) {
			[self runLayer:[CHGameLayer node]];
		}];
		
		CCMenu *testMenu = [CCMenu menuWithItems:itemTest1, itemTest2, nil];
		
		
		// Change the font of each menu item
		for (CCMenuItemFont *item in testMenu.children) 
		{
			item.fontName = @"HelveticaNeue-Bold";
			item.fontSize = 14;			
		}
		
		[testMenu alignItemsVertically];
		
		// Effect
		int delayScale = 0;
		for (CCNode *item in testMenu.children) 
		{
			CGPoint p = item.position;
			float offset = -(p.y + 20 + [[CCDirector sharedDirector] winSize].height * 0.5f);
			
			item.position = ccp(p.x, p.y + offset);
			
			CCAction *animations = [CCSequence actions:
									[CCDelayTime actionWithDuration:delayScale * 0.3f], 
									[CCEaseElasticOut actionWithAction:[CCMoveBy actionWithDuration:1.5f position:ccp(0, -offset)]], nil];
			
			[item runAction:animations];
			
			delayScale++;
		}		
		
		[self addChild:testMenu];
		
		// team logo
		CCSprite *sprite = [CCSprite spriteWithFile:@"testLayer-teamLogo.png"];
		sprite.position = ccp(160, 360);
		[self addChild:sprite];
	}
	return self;
}
@end
