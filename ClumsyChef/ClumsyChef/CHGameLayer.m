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


static CGFloat const kChefYOffset = 100.f;

// When objected go out of the screen at the top and beyond this distance,
// They get removed
static float const kObjectActiveRangeUp = 400.f;
static float const kGenObjectRangeDown = 100.f;		// For generating objects before they appears


@implementation CHGameLayer
{
	CCLabelBMFont *_debugLabel;
	CHChefObject *_chefObj;
	
	float _bottomWorldOffset;
	float _nextGenItemsOffset;

	
	// TODO: shared particle effects, sound effects
}


#pragma mark -
#pragma mark Private

- (CGPoint)positionForChef
{
	return CGPointMake(_chefObj.position.x, CHGetWinHeight() - kChefYOffset);
}

- (void)setDebugDisplayText:(NSString *)text
{
	[_debugLabel setString:text];
	_debugLabel.anchorPoint = ccp(1, 1);
	_debugLabel.position = CHGetWinPointTR(20, 20);
}

- (CGFloat)generateItemsAtY:(CGFloat)y	// Return the interval after which the next generation takes place
{
	CGPoint p = ccp(CCRANDOM_0_1() * CHGetWinWidth(), y);
	CHGameObject *item = [CHCoinObject node];//[[CHGameLibrary sharedGameLibrary] gameObjectWithID:CHRecipeItemTest];
	item.position = p;
	item.verticalSpeed = CCRANDOM_0_1() * 30.f;
	[self addChild:item];
	
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
		
		_bottomWorldOffset = CHGetWinHeight();
		_nextGenItemsOffset = _bottomWorldOffset;
		
		_debugLabel = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:@"font-testFont.fnt"] autorelease];
		[_debugLabel setColor:ccGREEN];
		
		[self addChild:_debugLabel];

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
	//CHGameScene *gsParent = [self gameSceneParent];
	
	// Update objects
	CGFloat oldOffset = _chefObj.position.y;
	[_chefObj update:dt];
	
	CGFloat pullUp = oldOffset - _chefObj.position.y;
	
	// Pull everything up
	CGPoint delta = ccp(0, pullUp);
	
	_chefObj.position = ccpAdd(_chefObj.position, delta);
	CGFloat cullThresh = CHGetWinHeight() + kObjectActiveRangeUp;
	CGFloat chefRadius = MAX(_chefObj.contentSize.width, _chefObj.contentSize.height) * 0.5f;
	
	CHItemObject *item;
	
	// A array shouldn't be mutabled (cased by [CCNode removeFromParentAndCleanup:YES] 
	// during enumeration or it will crash
	// So here we made a copy
	CCArray *copyOfChildren = [self.children copy];
	CCARRAY_FOREACH(copyOfChildren, item)
	{
		if (![item isKindOfClass:[CHItemObject class]])
		{
			continue;
		}
		
		// Update the item
		[item update:dt];
		CGPoint p = ccpAdd(item.position, delta);
		
		// Perform culling
		if (p.y >= cullThresh)
		{
			[item removeFromParentAndCleanup:YES];
		}
		else
		{
			item.position = p;
			
			// Detect collision
			CGFloat itemRadius = MAX(item.contentSize.width, item.contentSize.height) * 0.5f;
			CGFloat dist = ccpDistance(_chefObj.position, item.position);
			if (dist < chefRadius + itemRadius)
			{
				[item didCollideWithChef];
			}
		}		
	}
	
	_bottomWorldOffset += pullUp;
	
	// Notify the parent
//	[gsParent worldOffsetDidChange:_bottomWorldOffset];
	
	// Generate new items
	while (_bottomWorldOffset + kGenObjectRangeDown >= _nextGenItemsOffset)
	{
		CGFloat y = -(_nextGenItemsOffset - _bottomWorldOffset);
		float interval = [self generateItemsAtY:y];
		
		// Next round
		_nextGenItemsOffset += interval;
	}
	
	//[self setDebugDisplayText:[NSString stringWithFormat:@"%d", [_items count]]];
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
#pragma mark Item API

- (void)chefDidCollectCoin:(CHGameObject *)coinObject
{
	
}

- (void)chefDidTouchHarmfulItem:(CHGameObject *)item
{
	
}

- (void)chefDidCollectReceiptItem:(CHGameObject *)item
{
	
}

@end
