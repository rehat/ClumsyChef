//
//  CHChefObject.m
//  ClumsyChef
//
//  Created by Tong on 28/10/11.
//  Copyright 2011 Think Bulbs Ltd. All rights reserved.
//

#import "CHChefObject.h"
#import "CHGameLibrary.h"
static CGFloat const kMaxSpeed = 150;
static CGFloat const kNormalSpeed = 60;

@implementation CHChefObject
{
	float _verticalAcc;
	float _horizontalAcc;
}

+ (CHChefObject *)chefObject
{
	CHGameItemInfo *info = [[CHGameLibrary sharedGameLibrary] gameObjectInfoWithID:CHGameObjectIDChef];
	return [[[CHChefObject alloc] initWithRepresentedItem:info] autorelease];
}

- (id)initWithRepresentedItem:(CHGameItemInfo *)item
{
	if (self = [super initWithRepresentedItem:item])
	{
		self.verticalSpeed = kNormalSpeed;
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)update:(float)dt
{
	float vSpeed = self.verticalSpeed + _verticalAcc * dt;
	vSpeed = clampf(vSpeed, kNormalSpeed, kMaxSpeed);
	self.verticalSpeed = vSpeed;
	
	[super update:dt];
}

- (void)startAccelerating
{
	_verticalAcc = 40;
}

- (void)stopAccelerating
{
	_verticalAcc = -65;
}

- (void)setHorizontalAcceleration:(float)a
{
	// Constants
	const float sensitivity = 1300.f;
	const float threshold = 0.1f;
	const float power = 1.61803399f;	// Golden ratio
	
	//[self setDebugDisplayText:[NSString stringWithFormat:@"x=%lf", acceleration.x]];
	
	// Adjust horizontal speed according to accleration values
	float accX = (float)fabs(a);
	if (accX > threshold)
	{
		BOOL isPositive = (a > 0);
		float v = powf(accX, power) * sensitivity * (isPositive? 1 : -1);
		self.horizontalSpeed= v;
	}
	else
	{
		self.horizontalSpeed = 0;
	}
}

@end
