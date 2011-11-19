//
//  CHHUDLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHHUDLayer.h"
#import "CHGameLibrary.h"


@implementation CHHUDLayer
{
	NSInteger	_numberOfLife;
	NSInteger	_moneyAmount;
    NSArray     *_goalItems;
    NSMutableDictionary *_hudGoalItems;
    
    CCLabelTTF *_lives;
    CCLabelTTF *_score;
    
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
        
        CCMenuItemImage *pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause-hd.png" selectedImage:@"PauseSelected-hd.png" target:self selector:@selector(gamePaused:)];
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




- (id)initWithRequiredRecipeItems:(CCArray *)itemIDs
{
	if (self = [super init])
	{
        _numberOfLife = 3;
        _moneyAmount = 0;
        
        _hudGoalItems = [[NSMutableDictionary alloc] initWithCapacity:[itemIDs count] ];

        
        //Create Menu Bar at top of HUD Layer
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCSprite *menuBar = [CCSprite spriteWithFile:@"HUDBar.png"];
        
        menuBar.position = ccp(screenSize.width/2, screenSize.height - menuBar.contentSize.height/2);
        [self addChild:menuBar];
        
        
        //-------------------------------------------
		// Recipe Goal Items
		//-------------------------------------------
        CGFloat horizontalPosition = 0;
        for (NSString *itemName in itemIDs) {
            CHRecipeItemInfo *item = [[CHGameLibrary sharedGameLibrary] recipeItemInfoWithName:itemName];
            CCSprite *tempSprite = [CCSprite spriteWithFile:[item spriteFilename]];
            horizontalPosition += tempSprite.contentSize.width/2;
            tempSprite.position = ccp(horizontalPosition, menuBar.position.y );
            horizontalPosition += tempSprite.contentSize.width;
            [_hudGoalItems setObject:tempSprite forKey:itemName];
        
            [self addChild:[_hudGoalItems objectForKey:itemName]];
            
        }
        
        //-------------------------------------------
		// Lives Label
		//-------------------------------------------
        CCSprite *chefHat = [CCSprite spriteWithFile:@"HUDLives.png"];
        _lives = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"x %d", _numberOfLife] fontName:@"Marker Felt" fontSize:20];
		[_lives setColor:ccBLACK];
        chefHat.position = ccp(20, screenSize.height - menuBar.contentSize.height/2 - 35 );
		_lives.position = ccp(chefHat.contentSize.width +20, screenSize.height - menuBar.contentSize.height/2 - 35 );
		[self addChild:chefHat];
        [self addChild:_lives];

        //-------------------------------------------
		// Score Label
		//-------------------------------------------
        _score = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"$ %d", _moneyAmount] fontName:@"Marker Felt" fontSize:20];
		[_score setColor:ccBLACK];
        _score.position = ccp(screenSize.width/2, screenSize.height - menuBar.contentSize.height/2 - 35 );
        [self addChild:_score];
        
        
        
        CCMenuItemImage *pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause2.png" selectedImage:@"PauseSelected2.png" target:self selector:@selector(gamePaused:)];
        //[pauseButton setAnchorPoint:ccp(1, 0)];
        pauseButton.position = ccp(145, 222);
        
        CCMenu *menu = [CCMenu menuWithItems:pauseButton, nil];
        //[menu addChild:pauseButton z:1 tag:1];
        [self addChild:menu];
        
        
        
        	}
	return self;
}

- (void) gamePaused:(id)sender {
    
}

- (void)dealloc
{   
    [_hudGoalItems release];
	[super dealloc];
}

+ (id)nodeWithRequiredRecipeItems:(CCArray *)itemIDs
{
	return [[[self alloc] initWithRequiredRecipeItems:itemIDs] autorelease];
}


#pragma mark -
#pragma mark Public

- (void)setRecipeItemCollected:(NSString*)itemID
{
    CCSprite *completed = [_hudGoalItems objectForKey:itemID];
    if (completed != nil) {
        CCSprite *check = [CCSprite spriteWithFile:@"HUDItemCheck.png"];
        check.position = completed.position;
        [self addChild:check ];
    }
}

- (void) updateScore:(NSInteger)amount
{
    _moneyAmount +=amount;
    [_score setString:[NSString stringWithFormat:@"$ %d", _moneyAmount]];
}

-(void) updateLives
{
    _numberOfLife -=1;
    [_lives setString:[NSString stringWithFormat:@"x %d", _numberOfLife]];
     
}

-(void) updateHeight
{
    
}



#pragma mark -
#pragma mark User interactions


@end
