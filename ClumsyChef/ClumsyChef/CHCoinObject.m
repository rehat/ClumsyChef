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
    CCSprite *_coin;
}

- (id)init
{
	if (self = [super init])
	{
        _coin = [CCSprite spriteWithFile:@"coinObject-coin.png"];
        [self addChild:_coin];
    }
	return self;
}

- (CGSize)contentSize
{
    return _coin.contentSize;
}

- (void)collected
{   
	// Craete the particle effect
	NSDictionary *dict = [[CHSharedResHolder sharedResHolder] coinParticleEffectDict];
	CCParticleSystemQuad *emitter = [[[CCParticleSystemQuad alloc] initWithDictionary:dict] autorelease];
	emitter.position = _coin.position;
    emitter.autoRemoveOnFinish = YES;
    
	// Insert score label
	CCLabelBMFont *amount = [CCLabelBMFont labelWithString:@"+10" 
												   fntFile:@"gameLayer-collisionScoreFont.fnt"];
    amount.position = _coin.position;
    [emitter addChild:amount];
	
	[self addChild:emitter];
    
	// Play sound
    [[SimpleAudioEngine sharedEngine] playEffect:@"coin.caf"];
    [self removeChild:_coin cleanup:YES];
	_coin = nil;
    [self schedule: @selector(removeFromParent) interval:.8];
}

- (void)removeFromParent
{
    [[self gameLayerParent] removeChild:self cleanup:YES];
}

@end
