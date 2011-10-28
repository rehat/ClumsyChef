//
//  CHGameLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHGameLayer.h"
#import "CHGameLibrary.h"
#import "CHUtilities.h"
#import "CHChefObject.h"

static CGFloat const kChefYOffset = 100.f;

// When objected go out of the screen at the top and beyond this distance,
// They get removed
static float const kObjectActiveRangeUp = 400.f;



@implementation CHGameLayer
{
	CCLabelBMFont *_debugLabel;
	
	CHChefObject *_chefObj;
	CCArray *_items;
	
	float bottomWorldOffset;
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

#pragma mark - 
#pragma mark Constructor and destructor

- (id)init	// TODO: Init with scene description
{
	if (self = [super initWithColor:ccc3To4(ccWHITE)])
	{
		// Sensors
		self.isTouchEnabled = true;
		self.isAccelerometerEnabled = true;
		
		
		
		// Chef objects
		_chefObj = [[CHChefObject chefObject] retain];
		_chefObj.position = ccp(CHGetWinWidth() / 2, 0);
		_chefObj.position = [self positionForChef];
		[self addChild:_chefObj];
		
		bottomWorldOffset = CHGetWinHeight();
		
		// Items
		_items = [[CCArray alloc] initWithCapacity:64];
		
		for (int i=0; i<10; i++) 
		{
			CGPoint p = CGPointMake(CCRANDOM_0_1() * CHGetWinWidth(), CCRANDOM_0_1() * CHGetWinHeight());
			CHGameObject *obj = [[[CHGameLibrary sharedGameLibrary] gameObjectWithID:CHGameObjectIDTestItem] retain];
			obj.position = p;
			obj.verticalSpeed = CCRANDOM_0_1() * 30;
			
			[_items addObject:obj];
			[self addChild:obj];
		}
		
		_debugLabel = [[CCLabelBMFont alloc] initWithString:@"" fntFile:@"font-testFont.fnt"];
		[self addChild:_debugLabel];

		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		[self scheduleUpdate];
	}
	return self;
}

- (void)dealloc
{
	[_debugLabel release];
	[_items release];
	[_chefObj release];
}


#pragma mark -
#pragma mark xxx

- (void)update:(ccTime)dt
{
	// Update objects
	CGFloat oldOffset = _chefObj.position.y;
	[_chefObj update:dt];
	
	CGFloat pullUp = oldOffset - _chefObj.position.y;

	// Pull everything up
	CGPoint delta = ccp(0, pullUp);
	[self setDebugDisplayText:[NSString stringWithFormat:@"%.f", _chefObj.verticalSpeed]];
	
	_chefObj.position = ccpAdd(_chefObj.position, delta);
	for (CHGameObject *item in _items) 
	{
		[item update:dt];
		item.position = ccpAdd(item.position, delta);
	}
	
	bottomWorldOffset += pullUp;
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

@end
