//
//  CHChefObject.m
//  ClumsyChef
//
//  Created by Tong on 28/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHChefObject.h"
#import "CHGameLibrary.h"
#import "CHGameLayer.h"


static CGFloat const kMaxSpeed = 300;
static CGFloat const kNormalSpeed = 200;
static CGFloat const kFallAcceleration = 100;
static CGFloat const kFallDeceleration = -130;

NSInteger const chefTag = 45;

@implementation CHChefObject
{
    CCSprite *_chef;
	float _verticalAcc;
	float _horizontalAcc;
    float _verticalSpeed;
	float _horizontalSpeed;
}

@synthesize verticalSpeed = _verticalSpeed;
@synthesize horizontalSpeed = _horizontalSpeed;

#pragma mark -
#pragma Private

- (CHGameLayer *)gameLayerParent
{
	CHGameLayer *p = (CHGameLayer *)[self parent];
	if ([p isKindOfClass:[CHGameLayer class]])
	{
		return p;
	}
	return nil;
}

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
	if ((self = [super init]))
	{
		CCTexture2D *chefAtlas = [[CCTextureCache sharedTextureCache] addImage:@"chefAtlas.png"];
		
		NSArray *frames = [NSArray arrayWithObjects:
						   [CCSpriteFrame frameWithTexture:chefAtlas rect:CGRectMake(0, 0, 75, 75)],
						   [CCSpriteFrame frameWithTexture:chefAtlas rect:CGRectMake(75, 0, 75, 75)],
						   [CCSpriteFrame frameWithTexture:chefAtlas rect:CGRectMake(150, 0, 75, 75)],
						   [CCSpriteFrame frameWithTexture:chefAtlas rect:CGRectMake(75, 0, 75, 75)], nil];
		CCAnimation *animation = [CCAnimation animationWithFrames:frames delay:0.07f];
		CCAnimate *anim = [CCAnimate actionWithAnimation:animation];
		
		_chef = [CCSprite node];
		[self addChild:_chef];
		
		[_chef runAction:[CCRepeatForever actionWithAction:anim]];
		
		self.verticalSpeed = kNormalSpeed;
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

#pragma mark -
#pragma mark Control

- (void)update:(float)dt
{
	if ([self gameLayerParent].isPaused)
		return;
	
	float vSpeed = self.verticalSpeed + _verticalAcc * dt;
	vSpeed = clampf(vSpeed, kNormalSpeed, kMaxSpeed);
	self.verticalSpeed = vSpeed;
	
    CGPoint p = self.position;
	p.x += _horizontalSpeed * dt;
	p.y -= _verticalSpeed * dt;
	
	self.position = p;
    
    
    //rotate chef based on direction
	CGFloat rot = 15 * (self.horizontalSpeed / 100);
    _chef.rotation = clampf(rot, -60, 60);
    
	// Correct coordinate so that it doesn't go out of bounds
	CGFloat halfWidth = 0.5f * _chef.contentSize.width;
    
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

- (CGSize) contentSize
{
    return CGSizeMake(45, 45);
}

-(BOOL) recentlyHit
{
    return [_chef numberOfRunningActions] > 1;
}


-(void) chefDamaged
{
    CCBlink *blink = [CCBlink actionWithDuration:0.8f blinks:7];
	[_chef runAction:blink];
//    [_chef setOpacity:1.0];
//    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.2 opacity:100];
//    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.2 opacity:255];
//    
//    CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
//    
//    CCSequence *pulseSequence2 = [CCSequence actionOne:pulseSequence two:pulseSequence];
//    pulseSequence2.tag = 5;
//    [_chef runAction:pulseSequence2];
}


@end
