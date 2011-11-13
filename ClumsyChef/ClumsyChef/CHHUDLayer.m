//
//  CHHUDLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHHUDLayer.h"

@implementation CHHUDLayer
{
	NSInteger	_numberOfLife;
	NSInteger	_moneyAmount;
}

@synthesize numberOfLife = _numberOfLife;
@synthesize moneyAmount = _moneyAmount;


#pragma mark -
#pragma mark Constructor and destructor

- (id)initWithRequiredRecipeItems
{
	if (self = [super init])
	{
        //// Set up sprites, labels and pause button (CCMenu)
        
        //windowSize = [[CCDirector sharedDirector] winSize];
        
        CCMenuItemImage *pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause.png" selectedImage:@"PauseSelected.png" target:self selector:@selector(gamePaused:)];
        [pauseButton setAnchorPoint:ccp(1, 0)];
        pauseButton.position = ccp(90, 90);
        
        CCMenu *menu = [CCMenu menuWithItems:pauseButton, nil];
        //[menu addChild:pauseButton z:1 tag:1];
        [self addChild:menu];
        
        
        
        //CCMenuItem *pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause.png" selectedImage:@"PauseSelected.png" block:^(id sender) {
        //    [[CCDirector sharedDirector] popScene];
        //}]; //}selector:@selector(gamePaused:)];
        ////pauseButton.position = cpp(100, 100);
        //CCMenu *pauseMenu = [CCMenu menuWithItems:pauseButton, nil];
        //[pauseMenu setPositionSharp:CHGetWinPointTL(40, 40)];
        ////CCLayer *layer = [CCLayer node];
        ////pauseMenu.position = CGPointZero;
        ////[self addChild:pauseMenu];
        
        ////[layer addChild:pauseMenu];
		
		////[self addChild:layer];
		////layer.position = ccp(0, 0);
        
        /*
         
         
         + (CCMenu *)backButton
         {
         CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:@"testLayer-backButton.png" 
         selectedImage:@"testLayer-backButton-highlighted.png" 
         block:^(id sender) {
         [[CCDirector sharedDirector] popScene];
         }];
         CCMenu *menu = [CCMenu menuWithItems:item, nil];
         [menu setPositionSharp:CHGetWinPointTL(40, 40)];
         menu.tag = TestBackButtonTag;
         
         return menu;
         }
         
         */
	}
	return self;
}




- (id)init
{
	if (self = [super init])
	{
        //// Set up sprites, labels and pause button (CCMenu)
        
        //windowSize = [[CCDirector sharedDirector] winSize];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCSprite *menuBar = [CCSprite spriteWithFile:@"HUDBar.png"];
        //[menuBar setAnchorPoint:ccp(1, 0)];
        menuBar.position = ccp(10, 468);
       // menuBar.position = CGPointMake(screenSize.width - menuBar.contentSize.width/2,screenSize.height-menuBar.contentSize.height/2);
        [self addChild:menuBar];
        
        
        CCMenuItemImage *pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause2.png" selectedImage:@"PauseSelected2.png" target:self selector:@selector(gamePaused:)];
        //[pauseButton setAnchorPoint:ccp(1, 0)];
        pauseButton.position = ccp(145, 222);
        
        CCMenu *menu = [CCMenu menuWithItems:pauseButton, nil];
        //[menu addChild:pauseButton z:1 tag:1];
        [self addChild:menu];
        
        
        
        //CCMenuItem *pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause.png" selectedImage:@"PauseSelected.png" block:^(id sender) {
        //    [[CCDirector sharedDirector] popScene];
        //}]; //}selector:@selector(gamePaused:)];
        ////pauseButton.position = cpp(100, 100);
        //CCMenu *pauseMenu = [CCMenu menuWithItems:pauseButton, nil];
        //[pauseMenu setPositionSharp:CHGetWinPointTL(40, 40)];
        ////CCLayer *layer = [CCLayer node];
        ////pauseMenu.position = CGPointZero;
        ////[self addChild:pauseMenu];
        
        ////[layer addChild:pauseMenu];
		
		////[self addChild:layer];
		////layer.position = ccp(0, 0);
        
        /*
         
         
         + (CCMenu *)backButton
         {
         CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:@"testLayer-backButton.png" 
         selectedImage:@"testLayer-backButton-highlighted.png" 
         block:^(id sender) {
         [[CCDirector sharedDirector] popScene];
         }];
         CCMenu *menu = [CCMenu menuWithItems:item, nil];
         [menu setPositionSharp:CHGetWinPointTL(40, 40)];
         menu.tag = TestBackButtonTag;
         
         return menu;
         }

         */
	}
	return self;
}

- (void) gamePaused:(id)sender {
    
}

- (void)dealloc
{
	[super dealloc];
}

+ (id)nodeWithRequiredRecipeItems:(NSArray *)itemIDs
{
	return [[[self alloc] initWithRequiredRecipeItems:itemIDs] autorelease];
}


#pragma mark -
#pragma mark Public

- (void)setRecipeItemCollected:(NSString*)itemID
{
    
}

- (void) updateScore:(NSInteger)amount
{
    _moneyAmount +=amount;
    //TODO: update score label
}

-(void) updateLives
{
    _numberOfLife -=1;
    //TODO: update lives label
}

-(void) updateHeight
{
    
}



#pragma mark -
#pragma mark User interactions


@end
