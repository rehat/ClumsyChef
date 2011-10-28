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



NSInteger const TestBackButtonTag = -9999;

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
	[scene addChild:[TestMenuLayer backButton]];	// Add back button
	[[CCDirector sharedDirector] pushScene:scene];
}

- (void)runLayer:(CCLayer *)layer
{
	// Wrap it with a scene
	CCScene *scene = [CCScene node];
	[scene addChild:layer];
	[self runScene:scene];
}

- (CCMenuItem *)menuItemWithTitle:(NSString *)title block:(void (^)(id sender))block
{
	// Create the label
	CCLabelBMFont *label = [CCLabelBMFont labelWithString:title fntFile:@"font-testFont.fnt"];
	CCMenuItem *item = [CCMenuItemLabel itemWithLabel:label block:block];
	return item;
}

- (id)init
{
	if (self = [super initWithColor:ccc4Hex(0x80c8ff) fadingTo:ccc4Hex(0x0593ed)])
	{
		// Add the tests menu item here
		//-----------------------------------
		CCMenuItem *itemTest1 = [self menuItemWithTitle:@"Background Layer" block:^(id sender) {
			[self runLayer:[CHBackgroundLayer node]];
		}];

		CCMenuItem *itemTest2 = [self menuItemWithTitle:@"Game Layer" block:^(id sender) {
			[self runLayer:[CHGameLayer node]];
		}];
		
		CCMenu *testMenu = [CCMenu menuWithItems:itemTest1, itemTest2, nil];
		
		[testMenu alignItemsVertically];	
		
		CCLayer *layer = [CCLayer node];
		[layer addChild:testMenu];
		
		// team logo
		CCSprite *sprite = [CCSprite spriteWithFile:@"testLayer-teamLogo.png"];
		sprite.position = ccp(160, 360);
		[layer addChild:sprite];
		
		[self addChild:layer];
		layer.position = ccp(0, -480);
		[layer runAction:[CCEaseElasticOut actionWithAction:[CCMoveBy actionWithDuration:2.f position:ccp(0, 480)]]];
	}
	return self;
}

#pragma mark -
#pragma mark public APIs

+ (CCMenu *)backButton
{
	CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:@"testLayer-backButton.png" 
												   selectedImage:@"testLayer-backButton-highlighted.png" 
														   block:^(id sender) {
															   [[CCDirector sharedDirector] popScene];
														   }];
	CCMenu *menu = [CCMenu menuWithItems:item, nil];
	menu.position = CHGetWinPointTL(40, 40);
	menu.tag = TestBackButtonTag;
	
	return menu;
}
@end
