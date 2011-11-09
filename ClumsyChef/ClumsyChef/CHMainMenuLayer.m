//
//  CHMainMenuLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHMainMenuLayer.h"
#import "SimpleAudioEngine.h"

// private methods are declared in this manner to avoid "may not respond to ..." compiler warnings
@interface CHMainMenuLayer (PrivateMethods)
-(void) createMenu:(ccTime)delta;
-(void) goBackToPreviousScene;
-(void) changeScene:(id)sender;
-(void) menuItem1Touched:(id)sender;
-(void) menuItem2Touched:(id)sender;
-(void) menuItem3Touched:(id)sender;
@end

@implementation CHMainMenuLayer

CCSprite *background;

+(id) scene
{
	CCScene* scene = [CCScene node];
	CCLayer* layer = [CHMainMenuLayer node];
	[scene addChild:layer];
	return scene;
}

-(id) init
{
	if ((self = [super init]))
	{
		CCLOG(@"init %@", self);
		
		// wait a short moment before creating the menu so we can see it scroll in 
        background = [CCSprite spriteWithFile:@"MainMenuBackground.png"];
        background.position = CGPointMake(background.contentSize.width/2,background.contentSize.height/2);
        [self addChild:background];
        
        // set CCMenuItemFont default properties
        [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
        [CCMenuItemFont setFontSize:20];
        
        // create a few labels with text and selector
        CCMenuItemFont* item1 = [CCMenuItemFont itemFromString:@"High Scores!" target:self selector:@selector(menuItem1Touched:)];
        
        // create a menu item using existing sprites
        CCSprite* normal = [CCSprite spriteWithFile:@"play.png"];
        CCSprite* selected = [CCSprite spriteWithFile:@"play2.png"];
        CCMenuItemSprite* item2 = [CCMenuItemSprite itemFromNormalSprite:normal selectedSprite:selected target:self selector:@selector(menuItem2Touched:)];
//        CCMenuItemSprite *item2_x = [CCMenuItemSprite itemFromNormalSprite:normal selectedSprite:selected block:^(id sender)
//                                     {
//                                         CCLOG(@"xxx"); 
//                                     }];
        // create a toggle item using two other menu items (toggle works with images, too) 	 [CCMenuItemFont setFontName:@"STHeitiJ-Light"];
        
        CCMenuItemImage* toggleOn = [CCMenuItemImage itemFromNormalImage:@"sound-icon.png" selectedImage:@"sound-icon.png"];
        CCMenuItemImage* toggleOff = [CCMenuItemImage itemFromNormalImage:@"sound-off-icon.png" selectedImage:@"sound-off-icon.png"];
        CCMenuItemToggle* item3 = [CCMenuItemToggle itemWithTarget:self selector:@selector(menuItem3Touched:) items:toggleOn, toggleOff, nil];
        
        BOOL isMute = [[SimpleAudioEngine sharedEngine] mute];
        item3.selectedIndex = (isMute? 1 : 0);
        
        CCMenu* menu = [CCMenu menuWithItems:item1, item2, item3, nil];
        menu.anchorPoint = CGPointZero;
        menu.position = CGPointZero;
        
        menu.tag = 100;
        
        // create the menu using the items
        item1.position = ccp(20, 160);
        item2.position = ccp(170, 220);
        item3.position = ccp(item2.position.x, 100);
        
        [self addChild:menu];
	}
	return self;
}

-(void) goBackToPreviousScene
{
	// get the menu back
	CCNode* node = [self getChildByTag:100];
	NSAssert([node isKindOfClass:[CCMenu class]], @"node is not a CCMenu!");
    
	CCMenu* menu = (CCMenu*)node;
    
	// lets move the menu out using a sequence
	CGSize size = [[CCDirector sharedDirector] winSize];
	CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:CGPointMake(-(size.width / 2), size.height / 2)];
	CCEaseBackInOut* ease = [CCEaseBackInOut actionWithAction:move];
	CCCallFunc* func = [CCCallFunc actionWithTarget:self selector:@selector(changeScene:)];
	CCSequence* sequence = [CCSequence actions:ease, func, nil];
	[menu runAction:sequence];
}

-(void) changeScene:(id)send
{
	//[[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
}

-(void) menuItem1Touched:(id)sender
{
	CCLOG(@"item 1 touched: %@", sender);
	[self goBackToPreviousScene];
}

-(void) menuItem2Touched:(id)sender
{
	CCLOG(@"item 2 touched: %@", sender);
}

-(void) menuItem3Touched:(id)sender
{
	// sender is a CCMenuItemToggle in this case
	CCMenuItemToggle* toggleItem = (CCMenuItemToggle*)sender;
	int index = [toggleItem selectedIndex];
	
	CCLOG(@"item 3 touched: %@ - selected index: %i", sender, index);
    
    SimpleAudioEngine *e = [SimpleAudioEngine sharedEngine];
    [e setMute:![e mute]];
}

-(void) dealloc
{
	CCLOG(@"dealloc: %@", self);
	
	// always call [super dealloc] at the end of every dealloc method
	[super dealloc];
}

@end