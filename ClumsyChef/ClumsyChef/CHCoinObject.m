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

@implementation CHCoinObject
{
    CCSprite *coin;
    CCParticleSystemQuad *emitter;

}


- (id)init
{
	if (self = [super init])
	{
        coin = [CCSprite spriteWithFile:@"gameObject-testIcon.png"];
        emitter = [CCParticleSystemQuad particleWithFile:@"coinObject-particle.plist"];
        [self addChild:coin];
    }
	return self;
}

- (CGSize) contentSize{
    
    return coin.contentSize;
}


+ (void)preloadSharedResources
{
	// TODO
}

+ (void)unloadSharedResources
{
	// TODO
}

-(void)coinLabel{
    CCLabelTTF *amount = [CCLabelTTF labelWithString:@"+10" fontName:@"Marker Felt" fontSize:14];
    amount.position = coin.position;
    [emitter addChild:amount];
}


- (void)didCollideWithChef
{   
    emitter.position = coin.position;
    emitter.autoRemoveOnFinish = YES;
    [self addChild:emitter];
    
    [self coinLabel];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"coin.caf"];
	[[self gameSceneParent] addChefMoney:10];
    [self removeChild:coin cleanup:YES];
    [self schedule: @selector(removeFromParent) interval:.8];
}


-(void)removeFromParent{
    [[self gameLayerParent] removeChild:self cleanup:YES];
}
@end
