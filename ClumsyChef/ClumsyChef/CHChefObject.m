//
//  CHChefObject.m
//  ClumsyChef
//
//  Created by Tong on 28/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHChefObject.h"
#import "CHGameLibrary.h"

static CGFloat const kMaxSpeed = 200;
static CGFloat const kNormalSpeed = 100;
static CGFloat const kFallAcceleration = 100;
static CGFloat const kFallDeceleration = -130;


@implementation CHChefObject
{
	float _verticalAcc;
	float _horizontalAcc;
}

+ (id)node
{
	return [[[self alloc] initWithFile:@"gameObject-testIconBlue.png"] autorelease];
}

- (id)initWithFile:(NSString *)filename
{
	if (self = [super initWithFile:filename])
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
	
	// Correct coordinate so that it doesn't go out of bounds
	CGFloat halfWidth = 0.5f * self.contentSize.width;
	CGPoint p = self.position;
	p.x = clampf(p.x, halfWidth, CHGetWinWidth() - halfWidth);
	self.position = p;
}

- (void)startAccelerating
{
	_verticalAcc = kFallAcceleration;
}

- (void)stopAccelerating
{
	_verticalAcc = kFallDeceleration;
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
