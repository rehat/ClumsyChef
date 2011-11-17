//
//  CHCoinObject.m
//  ClumsyChef
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHCoinObject.h"
#import "CHGameScene.h"
#import "SimpleAudioEngine.h"
#import "CHSharedResHolder.h"


@implementation CHCoinObject
{
    CCSprite *coin;
}

- (id)init
{
	if (self = [super init])
	{
        coin = [CCSprite spriteWithFile:@"coinObject-coin.png"];
        [self addChild:coin];
    }
	return self;
}

- (CGSize)contentSize
{
    return coin.contentSize;
}

- (void)collected
{   
	// Craete the particle effect
	NSDictionary *dict = [[CHSharedResHolder sharedResHolder] coinParticleEffectDict];
	CCParticleSystemQuad *emitter = [[[CCParticleSystemQuad alloc] initWithDictionary:dict] autorelease];
	emitter.position = coin.position;
    emitter.autoRemoveOnFinish = YES;
    
	// Insert score label
	// TODO: optimize using Bitmap font instead of TTF
	CCLabelTTF *amount = [CCLabelTTF labelWithString:@"+10" fontName:@"Marker Felt" fontSize:14];
    amount.position = coin.position;
    [emitter addChild:amount];
	
	[self addChild:emitter];
    
	// Play sound
    [[SimpleAudioEngine sharedEngine] playEffect:@"coin.caf"];
    [self removeChild:coin cleanup:YES];
    [self schedule: @selector(removeFromParent) interval:.8];
}

- (void)removeFromParent
{
    [[self gameLayerParent] removeChild:self cleanup:YES];
}

@end
