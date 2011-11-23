//
//  CHHarmfulObject.m
//  ClumsyChef
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHHarmfulObject.h"
#import "CHGameScene.h"
#import "SimpleAudioEngine.h"
#import "CCParticleSystemPoint.h"
#import "CHSharedResHolder.h"
#import "CHGameLayer.h"


@implementation CHHarmfulObject
{
    CCSprite *_knife;
	CGFloat _rotationSpeed;
}

- (id)init
{
	if (self = [super init])
	{
		NSString *filename = ((CCRANDOM_0_1() > 0.5f)? @"harmfulObject-smallKnife.png" : @"harmfulObject-knife2.png");
		_knife = [[CCSprite alloc] initWithFile:filename];
		_rotationSpeed = 80.f + CCRANDOM_0_1() * 60.f;
		
		[self addChild:_knife];
        [self scheduleUpdate];
    }
	return self;
}

- (void)dealloc
{
	[_knife release];
	[super dealloc];
}

- (CGSize)contentSize
{    
    return _knife.contentSize;
}

- (void)update:(ccTime)delta
{   
	if ([self gameLayerParent].isPaused)
		return;
	
	// Update rotation
	_knife.rotation += _rotationSpeed * delta;
}

- (void)collected
{   
	// Craete the particle effect
	NSDictionary *dict = [[CHSharedResHolder sharedResHolder] harmfulParticleEffectDict];
	CCParticleSystemQuad *emitter = [[[CCParticleSystemQuad alloc] initWithDictionary:dict] autorelease];
	emitter.position = _knife.position;
    emitter.autoRemoveOnFinish = YES;
    
	// Insert damage label
	// TODO: optimize using Bitmap font instead of TTF
	CCLabelTTF *amount = [CCLabelTTF labelWithString:@"-1" fontName:@"Marker Felt" fontSize:20];
    amount.position = _knife.position;
    [emitter addChild:amount];
	
	[self addChild:emitter];
    
	// Play sound
    [[SimpleAudioEngine sharedEngine] playEffect:@"Oowh.caf"];
    [self removeChild:_knife cleanup:YES];
    [self schedule: @selector(removeFromParent) interval:1];
}

- (void)removeFromParent
{
    [[self gameLayerParent] removeChild:self cleanup:YES];
}

@end
