//
//  CHGameLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHGameLayer.h"
#import "CHGameLibrary.h"
#import "CHChefObject.h"
#import "CHGameScene.h"
#import "CHCoinObject.h"
#import "CHHarmfulObject.h"
#import "CHBackgroundLayer.h"
#import "CHRecipeItemObject.h"
#import "SimpleAudioEngine.h"
#import "CHHUDLayer.h"
#import "CHSharedResHolder.h"
#import "CHPauseLayer.h"
#import "TestMenuLayer.h"


static CGFloat const kChefYOffset = 110.f;
static NSInteger const kTagLiveRecipeItem = 711;


// When objected go out of the screen at the top and beyond this distance,
// They get removed
static float const kObjectActiveRangeUp = 100.f;
static float const kGenObjectRangeDown = 100.f;		

@implementation CHGameLayer
{
	CHChefObject *_chefObj;
    CHHUDLayer *_hudLayer;
    CHBackgroundLayer	*_bgLayer;
	BOOL _isPaused;
    NSUInteger _levelIndex;
	
	float _bottomWorldOffset;
	float _nextGenItemsOffset;
    
    CCArray *_liveGameObjects;
    CCArray *_goalRecipeItemIDs;
    
	NSInteger _levelHeight;
}

@synthesize isPaused = _isPaused;

#pragma mark -
#pragma mark Private

- (CGPoint)positionForChef
{
	return CGPointMake(_chefObj.position.x, CHGetWinHeight() - kChefYOffset);
}

- (CGFloat)generateItemsAtY:(CGFloat)y	// Return the interval after which the next generation takes place
{
	CGPoint p = ccp(CCRANDOM_0_1() * CHGetWinWidth(), y);
	
    CHItemObject *item;
    CGFloat x = CCRANDOM_0_1();
    if (x > .1f && x < .4f)  //better: (x > .1f && x < .2f)
	{   
        item = [CHHarmfulObject node];
        [self addChild:item];
    }
    else if(x <= .1f && [_goalRecipeItemIDs count] != 0)
	{
        NSUInteger randomIndex = (NSUInteger)arc4random() % [_goalRecipeItemIDs count];
		
        if([self getChildByTag:kTagLiveRecipeItem] != nil)	//checks to see if recipe item is already in the game
		{ 
            item = [CHCoinObject node];
            [self addChild:item];
        }
        else
		{
            item = [CHRecipeItemObject nodeWithItemID:[_goalRecipeItemIDs objectAtIndex:randomIndex]];
            [self addChild:item z:2 tag:kTagLiveRecipeItem];
        }    
    }
    else
	{
        item = [CHCoinObject node];
        [self addChild:item];	
    }
	
	item.position = p;
    [_liveGameObjects addObject:item];
	
	return 30;
}

- (CHGameScene *)gameSceneParent
{
	CHGameScene *p = (CHGameScene *)self.parent;
	if ([p isKindOfClass:[CHGameScene class]])
		return p;
	return nil;
}

- (CCMenu *)pauseButton
{
	CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:@"pause-gameLayerButton.png" 
												   selectedImage:@"pause-gameLayerButton-high.png" 
														  target:self 
														selector:@selector(pauseButtonPressed:)];
	CCMenu *menu = [CCMenu menuWithItems:item, nil];
	[menu setPositionSharp:CHGetWinPointBR(29, 31)];
	return menu;
}

- (void)prepareInitContents
{
	[CHSharedResHolder unloadSharedResources];
	[_goalRecipeItemIDs release];
	[_liveGameObjects release];
	
	[self removeAllChildrenWithCleanup:YES];
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

- (void)initContents
{
	//-------------------------------------------
	// Prepare game object's shared resources
	//-------------------------------------------
	[CHSharedResHolder loadSharedResources];
	
	//-------------------------------------------
	// Chef objects
	//-------------------------------------------
	_chefObj = [CHChefObject node];
	_chefObj.position = ccp(CHGetWinWidth() / 2, 0);
	_chefObj.position = [self positionForChef];
	[self addChild:_chefObj];
	
	//-------------------------------------------		
	// Set up the layer according to the stage info
	//-------------------------------------------
	
	CHLevelInfo *levelInfo = [[CHGameLibrary sharedGameLibrary] levelInfoAtIndex:_levelIndex];
	_goalRecipeItemIDs = [[CCArray alloc] initWithNSArray:levelInfo.recipeItems];
	
	_levelHeight = levelInfo.worldHeight;
	
	_bottomWorldOffset = CHGetWinHeight();
	_nextGenItemsOffset = _bottomWorldOffset;
	
	//-------------------------------------------
	// Background 
	//-------------------------------------------
	
	_bgLayer = [CHBackgroundLayer node];
	[_bgLayer setWorldHeight:levelInfo.worldHeight];
	[self addChild:_bgLayer z:-1];
	
	//Array of items in play
	_liveGameObjects = [[CCArray alloc ] initWithCapacity:100];
	
	//-------------------------------------------
	// HUD
	//-------------------------------------------
	_hudLayer = [CHHUDLayer nodeWithRequiredRecipeItems:levelInfo.recipeItems numberOfLifes:3 moneyAmount:0];
	[self addChild:_hudLayer z:5];
	
	//-------------------------------------------
	// PAUSE button
	//-------------------------------------------
	CCMenu *pauseButton = [self pauseButton];
	[self addChild:pauseButton z:5];
	
	//-------------------------------------------
	// Bg music
	//-------------------------------------------
	[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gameLayer-music.caf" loop:YES];
	
	if ([SimpleAudioEngine sharedEngine].willPlayBackgroundMusic) {
		[SimpleAudioEngine sharedEngine].backgroundMusicVolume = 0.4f;
	}
	
}

#pragma mark - 
#pragma mark Constructor and destructor

- (id)initWithLevelIndex:(NSUInteger)levelIndex
{
	if (self = [super init])
	{
		_levelIndex = levelIndex;
		
		// Sensors
		self.isTouchEnabled = true;
		self.isAccelerometerEnabled = true;
		
		[self initContents];
		_isPaused = NO;
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self 
														 priority:kCCMenuTouchPriority 
												  swallowsTouches:YES];
		[self scheduleUpdate];
	}
	return self;
}

- (void)dealloc
{
	[CHSharedResHolder unloadSharedResources];	// Unload
	
	[_goalRecipeItemIDs release];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	[super dealloc];
}

+ (id)nodeWithLevelIndex:(NSUInteger)levelIndex
{
	return [[[self alloc] initWithLevelIndex:levelIndex] autorelease];
}

+ (id)node
{
	NSAssert(NO, @"+node no longer used, use +nodeWithLevelIndex");
	return nil;
}


#pragma mark -
#pragma mark Suspending/Stopping

- (void)setIsPaused:(BOOL)isPaused
{
	if (_isPaused != isPaused)
	{
		// So far so good. may need to traverse the hierarchy if needed
		_isPaused = isPaused;		
		// TODO: bgm
	}
}

#pragma mark -
#pragma mark Main Update

- (void)update:(ccTime)dt
{
	if (_isPaused)
		return;
	
	// Update objects
	CGFloat oldOffset = _chefObj.position.y;    
	
	[_chefObj update:dt];
	
	CGFloat pullUp = oldOffset - _chefObj.position.y;
	
	// Delta position for pulling everything up
	CGPoint delta = ccp(0, pullUp);
	
	_chefObj.position = ccpAdd(_chefObj.position, delta);
	CGFloat cullThresh = CHGetWinHeight() + kObjectActiveRangeUp;
    
	CGFloat chefRadius = MIN(_chefObj.contentSize.width, _chefObj.contentSize.height) * 0.5f;
	
	CHItemObject *item;
	
	// A array shouldn't be mutabled (cased by [CCNode removeFromParentAndCleanup:YES] 
	// during enumeration or it will crash
	// So here we made a copy
	
	CCARRAY_FOREACH(_liveGameObjects, item)
	{
		
		CGPoint p = ccpAdd(item.position, delta);
		
		
		// Perform culling
		if (p.y >= cullThresh)
		{
			[item removeFromParentAndCleanup:YES];
            [_liveGameObjects removeObject:item];
		}
		else
		{
			item.position = p;
			
			// Detect collision
			CGFloat itemRadius = MAX(item.contentSize.width, item.contentSize.height) * 0.5f;
			CGFloat dist = ccpDistance(_chefObj.position, item.position);
			
			if (dist < chefRadius + itemRadius)
			{
                [item collected];
                
				//Harmful: Update health and check if it's game over
                if ([item isKindOfClass:[CHHarmfulObject class]]) 
				{    
					//prevents chef getting hit twice in a row
                    if (![_chefObj recentlyHit]) 
                    {   
                        [_chefObj chefDamaged];		//fadding in/out 
                        _hudLayer.numberOfLifes--;  //updating HUD
                        if (_hudLayer.numberOfLifes <1) 
						{                            
                            [[self gameSceneParent] showGameOver];
							break;
                        }
                    }                                       
                }
				else if([item isKindOfClass:[CHCoinObject class]])
				{
					//Coin:  Update player's score (maybe play a sound for every 1000)    
					_hudLayer.moneyAmount += 10;
                }
				else
				{
					//Recipe:  Update HUD and left over itmes needed.  Then check if its game win
                    if ([item isKindOfClass:[CHRecipeItemObject class]]) 
					{
                        NSString *checkRecipe;
                        CHRecipeItemObject *checkMe = (CHRecipeItemObject*)item;
						
                        CCARRAY_FOREACH(_goalRecipeItemIDs, checkRecipe)
						{
                            if( [checkRecipe isEqualToString:checkMe.itemID])
							{
                                [_goalRecipeItemIDs removeObject:checkRecipe];
								[_hudLayer setRecipeItemCollected:checkRecipe];
                                break;
                            }
                        }
                        
						if([_goalRecipeItemIDs count] == 0)
						{    
                            //TODO: update player info with score and level cleared
                            [[self gameSceneParent] showWin:_hudLayer.moneyAmount];
							break;
                        }
                    }
                }
                [_liveGameObjects removeObject:item];
			}
		}		
	}
	
	_bottomWorldOffset += pullUp;
    
    [_bgLayer updatePull:_bottomWorldOffset];	
    
    if(_bottomWorldOffset > _levelHeight){
        [[self gameSceneParent] showGameOver];
    }
    
	// Update the HUD progress
	[_hudLayer setProgress:(_bottomWorldOffset - CHGetWinHeight()) / (_levelHeight - CHGetWinHeight())];
	
	// Generate new items
    
    
	while (_bottomWorldOffset + kGenObjectRangeDown >= _nextGenItemsOffset)
	{   
		
		CGFloat y = -(_nextGenItemsOffset - _bottomWorldOffset);
		float interval = [self generateItemsAtY:y];
		// Next round
		_nextGenItemsOffset += interval;
	}
}

#pragma mark -
#pragma mark Sensors

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
	[_chefObj setHorizontalAcceleration:acceleration.x];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	[_chefObj startAccelerating];
	return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	[_chefObj stopAccelerating];
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
	[_chefObj stopAccelerating];
}

#pragma mark - 
#pragma mark public

- (void)resetForLevelIndex:(NSUInteger)levelIndex
{
	_levelIndex = levelIndex;
	[self prepareInitContents];
	[self initContents];
}

- (void)stopBackgroundMusic
{
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

#pragma mark -
#pragma mark UI events
//BOOL paused = false;
- (void)pauseButtonPressed:(id)sender
{
}

@end
