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



static CGFloat const kChefYOffset = 100.f;

// When objected go out of the screen at the top and beyond this distance,
// They get removed
static float const kObjectActiveRangeUp = 100.f;
static float const kGenObjectRangeDown = 100.f;		// For generating objects before they appears


@implementation CHGameLayer
{
	CHChefObject *_chefObj;
    
	float _bottomWorldOffset;
	float _nextGenItemsOffset;
    
    CCArray *itemsArray;
    CCArray *goalItemsArray;
	
	// TODO: shared particle effects, sound effects
}


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
    if (x > .1f && x < .4f) {
        item = [CHHarmfulObject node];
        [self addChild:item];
    }
    else if(x <= .1f && [goalItemsArray count] != 0){
        NSUInteger randomIndex = (NSUInteger)arc4random() % [goalItemsArray count];
        if([self getChildByTag:711] != nil){ //checks to see if recipe item is already in the game
            item = [CHCoinObject node];
            [self addChild:item];
        }
        else{
            item = [CHRecipeItemObject node:[goalItemsArray objectAtIndex:randomIndex]];
            [self addChild:item z:2 tag:711];
        }    


    }
    else{
        item = [CHCoinObject node];
        [self addChild:item];

    }
	item.position = p;
	//item.verticalSpeed = CCRANDOM_0_1() * 30.f;
	
    
    [itemsArray addObject:item];
    //[self addChild:item];

    
	
	return 30;
}

- (CHGameScene *)gameSceneParent
{
	CHGameScene *p = (CHGameScene *)self.parent;
	if ([p isKindOfClass:[CHGameScene class]])
		return p;
	return nil;
}

#pragma mark - 
#pragma mark Constructor and destructor

- (id)init	// TODO: Init with scene description
{
	if (self = [super init])
	{
		// Sensors
		self.isTouchEnabled = true;
		self.isAccelerometerEnabled = true;

		// Chef objects
		_chefObj = [CHChefObject node];
		_chefObj.position = ccp(CHGetWinWidth() / 2, 0);
		_chefObj.position = [self positionForChef];
		[self addChild:_chefObj];
        
        itemsArray = [[CCArray alloc ] initWithCapacity:100];
        
        
        CHGameLibrary *stageLibrary = [CHGameLibrary node:@"Stage1" ];
        
         
        goalItemsArray = [stageLibrary getRecipeItems];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gameLayer-music.caf" loop:YES];
        
        if ([SimpleAudioEngine sharedEngine].willPlayBackgroundMusic) {
            [SimpleAudioEngine sharedEngine].backgroundMusicVolume = 0.4f;
        }
        
        

        
		_bottomWorldOffset = CHGetWinHeight();
		_nextGenItemsOffset = _bottomWorldOffset;

		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		[self scheduleUpdate];
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}



#pragma mark -
#pragma mark xxx

- (void)update:(ccTime)dt
{
	CHGameScene *gsParent = [self gameSceneParent];
	CHBackgroundLayer *background = (CHBackgroundLayer *)[gsParent getChildByTag:11111];
    
	// Update objects
	CGFloat oldOffset = _chefObj.position.y;    

	[_chefObj update:dt];
	
	CGFloat pullUp = oldOffset - _chefObj.position.y;
	
    
	// Pull everything up
	CGPoint delta = ccp(0, pullUp);
    
    	
	_chefObj.position = ccpAdd(_chefObj.position, delta);
	CGFloat cullThresh = CHGetWinHeight() + kObjectActiveRangeUp;

    
	CGFloat chefRadius = MIN(_chefObj.contentSize.width, _chefObj.contentSize.height) * 0.5f;
	
	CHItemObject *item;
	
	// A array shouldn't be mutabled (cased by [CCNode removeFromParentAndCleanup:YES] 
	// during enumeration or it will crash
	// So here we made a copy
   
	CCARRAY_FOREACH(itemsArray, item)
	{
		
		CGPoint p = ccpAdd(item.position, delta);
		
                
		// Perform culling
		if (p.y >= cullThresh)
		{
			[item removeFromParentAndCleanup:YES];
            [itemsArray removeObject:item];
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
                if ([item isKindOfClass:[CHHarmfulObject class]]) {
                    
                        //prevents chef getting hit twice in a row
                    if (![_chefObj recentlyHit]) 
                    {   
                        [_chefObj chefDamaged];
                        //TODO:Take off one health and check if chef still has lives left
                    }                                       
                    
                        //Coin:  Update player's score (maybe play a sound for every 1000)    
                }else if([item isKindOfClass:[CHCoinObject class]]){
                        //TODO:add to player's score
                
                        //Recipe:  Update HUD and left over itmes needed.  Then check if its game win
                }else{
                
                        //Should be a recipe item
                
                }
                
                [itemsArray removeObject:item];
			}
		}		
	}
	
	_bottomWorldOffset += pullUp;
    
    [background updatePull:_bottomWorldOffset];	
    
    
	// Notify the parent
	[gsParent worldOffsetDidChange:_bottomWorldOffset]; 
	
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
#pragma mark xx

@end
