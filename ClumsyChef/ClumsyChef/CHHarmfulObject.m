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


NSInteger const knifeTag = 666;


@implementation CHHarmfulObject
{
    CCSprite *knife;
}

- (id)init
{
	if (self = [super init])
	{
        if (CCRANDOM_0_1() > 0.5f)
            knife = [CCSprite spriteWithFile:@"harmfulObject-smallKnife.png"];
        else
            knife = [CCSprite spriteWithFile:@"harmfulObject-knife2.png"];

        
        [self addChild:knife z:1 tag:knifeTag];
        [self scheduleUpdate];
    }
	return self;
}

- (CGSize)contentSize
{    
    return knife.contentSize;
}

- (void)update:(ccTime)delta
{   
    [self getChildByTag:knifeTag].rotation += 2;
}

- (void)collected
{   
	// Craete the particle effect
	NSDictionary *dict = [[CHSharedResHolder sharedResHolder] harmfulParticleEffectDict];
	CCParticleSystemQuad *emitter = [[[CCParticleSystemQuad alloc] initWithDictionary:dict] autorelease];
	emitter.position = knife.position;
    emitter.autoRemoveOnFinish = YES;
    
	// Insert damage label
	// TODO: optimize using Bitmap font instead of TTF
	CCLabelTTF *amount = [CCLabelTTF labelWithString:@"-1" fontName:@"Marker Felt" fontSize:20];
    amount.position = knife.position;
    [emitter addChild:amount];
	
	[self addChild:emitter];
    
	// Play sound
    [[SimpleAudioEngine sharedEngine] playEffect:@"Oowh.caf"];
    [self removeChild:knife cleanup:YES];
    [self schedule: @selector(removeFromParent) interval:1];
}

- (void)removeFromParent
{
    [[self gameLayerParent] removeChild:self cleanup:YES];
}

@end
