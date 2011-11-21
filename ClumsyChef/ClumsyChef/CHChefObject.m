//
//  CHChefObject.m
//  ClumsyChef
//
//  Created by Tong on 28/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHChefObject.h"
#import "CHGameLibrary.h"

static CGFloat const kMaxSpeed = 200; //better 400
static CGFloat const kNormalSpeed = 100; //better 300
static CGFloat const kFallAcceleration = 100;
static CGFloat const kFallDeceleration = -130;

NSInteger const chefTag = 45;

@implementation CHChefObject
{
    CCSprite *chef;
	float _verticalAcc;
	float _horizontalAcc;
    float _verticalSpeed;
	float _horizontalSpeed;
    
    
    
}

@synthesize verticalSpeed = _verticalSpeed;
@synthesize horizontalSpeed = _horizontalSpeed;



- (id)init
{
	if ((self = [super init]))
	{
        chef = [CCSprite spriteWithFile:@"chefObject-chef.png"];
		self.verticalSpeed = kNormalSpeed;
        [self addChild:chef z:0 tag:chefTag];
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
	
    CGPoint p = self.position;
	p.x += _horizontalSpeed * dt;
	p.y -= _verticalSpeed * dt;
	
	self.position = p;
    
    
    //rotate chef based on direction
    if(self.horizontalSpeed > 0){
        [self getChildByTag:chefTag].rotation = 15;
    }
    else if(self.horizontalSpeed < 0){
        [self getChildByTag:chefTag].rotation = -15;
    }
    else{
        [self getChildByTag:chefTag].rotation = 0;
    }
    
    
	// Correct coordinate so that it doesn't go out of bounds
	CGFloat halfWidth = 0.5f * [self getChildByTag:chefTag].contentSize.width;
    
    p = self.position;
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

- (CGSize) contentSize{
    return chef.contentSize;
}

-(BOOL) recentlyHit{
    return [chef numberOfRunningActions]>0;
}


-(void) chefDamaged{
    
    [chef setOpacity:1.0];
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.2 opacity:100];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.2 opacity:255];
    
    CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
    
    CCSequence *pulseSequence2 = [CCSequence actionOne:pulseSequence two:pulseSequence];
    pulseSequence2.tag = 5;
    [chef runAction:pulseSequence2];
}


@end
