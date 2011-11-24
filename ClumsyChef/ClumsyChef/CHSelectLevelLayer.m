//
//  CHSelectLevelLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHSelectLevelLayer.h"
#import "CHPlayerInfo.h"
#import "TestMenuLayer.h"
#import "CHUtilities.h"
#import "CHGameScene.h"


// private methods are declared in this manner to avoid "may not respond to ..." compiler warnings
@interface CHSelectLevelLayer (PrivateMethods)
-(void) createMenu:(ccTime)delta;
-(void) menuItem1Touched:(id)sender;
-(void) menuItem2Touched:(id)sender;
-(void) menuItem3Touched:(id)sender;
-(void) menuItem4Touched:(id)sender;
-(void) menuItem5Touched:(id)sender;
-(void) menuItem6Touched:(id)sender;
@end

@implementation CHSelectLevelLayer

CCSprite *background;

- (void)runScene:(CCScene *)scene
{
	[scene addChild:[TestMenuLayer backButton]];
	[[CCDirector sharedDirector] pushScene:scene];
}


- (id)init
{
	if (self = [super init])
	{
		// Test code, delete this when done testing
		//-----------------------------
		[CHPlayerInfo test];
		// ----------------------------
		
		CCLOG(@"init %@", self);
		
		// wait a short moment before creating the menu so we can see it scroll in 
		background = [CCSprite spriteWithFile:@"selectLevel-background.png"];
		background.position = CGPointMake(background.contentSize.width/2,background.contentSize.height/2);
		[self addChild:background];
		
		// create a menu item using existing sprites
		CCSprite* normal = [CCSprite spriteWithFile:@"selectLevel-hot_dog.png"];
		CCSprite* selected = [CCSprite spriteWithFile:@"selectLevel-hot_dog-high.png"];
		
		CCMenuItemSprite *levelOneButton = [CCMenuItemSprite itemFromNormalSprite:normal selectedSprite:selected block:^(id sender)
								   {
									   CCLOG(@"xxx");
									   [self runScene:[CHGameScene nodeWithLevelIndex:(0)]];
								   }];
		
		CCSprite* normal2 = [CCSprite spriteWithFile:@"selectLevel-taco.png"];
		CCSprite* selected2 = [CCSprite spriteWithFile:@"selectLevel-taco-high.png"];
		
		CCMenuItemSprite *levelTwoButton = [CCMenuItemSprite itemFromNormalSprite:normal2 selectedSprite:selected2 block:^(id sender)
								   {
									   CCLOG(@"xxx");
									   [self runScene:[CHGameScene nodeWithLevelIndex:(1)]];
								   }];
		
		CCSprite* normal3 = [CCSprite spriteWithFile:@"selectLevel-hamburger.png"];
		CCSprite* selected3 = [CCSprite spriteWithFile:@"selectLevel-hamburger-high.png"];
		
		CCMenuItemSprite *levelThreeButton = [CCMenuItemSprite itemFromNormalSprite:normal3 selectedSprite:selected3 block:^(id sender)
								   {
									   CCLOG(@"xxx");
									[self runScene:[CHGameScene nodeWithLevelIndex:(3)]];
								   }];
		CCSprite* normal4 = [CCSprite spriteWithFile:@"selectLevel-burrito.png"];
		CCSprite* selected4 = [CCSprite spriteWithFile:@"selectLevel-burrito-high.png"];
		
		CCMenuItemSprite *levelFourButton = [CCMenuItemSprite itemFromNormalSprite:normal4 selectedSprite:selected4 block:^(id sender)
								   {
									   CCLOG(@"xxx");
									  [self runScene:[CHGameScene nodeWithLevelIndex:(4)]];
								   }];
		CCSprite* normal5 = [CCSprite spriteWithFile:@"selectLevel-pizza.png"];
		CCSprite* selected5 = [CCSprite spriteWithFile:@"selectLevel-pizza-high.png"];
		
		CCMenuItemSprite *levelFiveButton = [CCMenuItemSprite itemFromNormalSprite:normal5 selectedSprite:selected5 block:^(id sender)
								   {
									   CCLOG(@"xxx");
									   [self runScene:[CHGameScene nodeWithLevelIndex:(5)]];
								   }];
		CCSprite* normal6 = [CCSprite spriteWithFile:@"selectLevel-locked.png"];
		CCSprite* selected6 = [CCSprite spriteWithFile:@"selectLevel-locked-high.png"];
		
		CCMenuItemSprite *levelSixButton = [CCMenuItemSprite itemFromNormalSprite:normal6 selectedSprite:selected6 block:^(id sender)
								   {
									   CCLOG(@"xxx");
									   //[self runScene:[CHGameScene nodeWithLevelIndex:(6)]];
								   }];
		
		
		CCMenu* menu = [CCMenu menuWithItems:levelOneButton, levelTwoButton, levelThreeButton, levelFourButton, levelFiveButton, levelSixButton, nil];
		menu.anchorPoint = CGPointZero;
		menu.position = CGPointZero;
		
		menu.tag = 100;
		
		// create the menu using the items
		levelOneButton.position = ccp(60, 320);
		levelTwoButton.position = ccp(160, 320);
		levelThreeButton.position = ccp(260, 320);
		levelFourButton.position = ccp(60, 220);
		levelFiveButton.position = ccp(160, 220);
		levelSixButton.position = ccp(260, 220);
		[self addChild:menu];
	}
	return self;
}

//		-(void) menuItem1Touched:(id)sender
//		{
//			CCLOG(@"item 1 touched: %@", sender);
//			//[self goBackToPreviousScene];
//		}

-(void) menuItem2Touched:(id)sender
{
	CCLOG(@"item 2 touched: %@", sender);
	
}

//		-(void) menuItem3Touched:(id)sender
//		{
//			// sender is a CCMenuItemToggle in this case
//			CCMenuItemToggle* toggleItem = (CCMenuItemToggle*)sender;
//			int index = [toggleItem selectedIndex];
//			
//			CCLOG(@"item 3 touched: %@ - selected index: %i", sender, index);
//			
//			SimpleAudioEngine *e = [SimpleAudioEngine sharedEngine];
//			[e setMute:![e mute]];
//		}
//		
//		-(void) menuItem4Touched:(id)sender
//		{
//			CCLOG(@"item 4 touched: %@", sender);
//			//[self goBackToPreviousScene];
//		}

-(void) dealloc
{
	CCLOG(@"dealloc: %@", self);
	
	// always call [super dealloc] at the end of every dealloc method
	[super dealloc];
}




@end
