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

NSInteger const knifeTag = 666;


@implementation CHHarmfulObject
{
    CCSprite *knife;
    CCParticleSystemQuad *emitter;
    
}


- (id)init
{
	if (self = [super init])
	{
        
        if(CCRANDOM_0_1()>.5)
            knife = [CCSprite spriteWithFile:@"harmfulObject-smallKnife.png"];
        else
            knife = [CCSprite spriteWithFile:@"harmfulObject-knife2.png"];

        
        
        
        emitter = [CCParticleSystemQuad particleWithFile:@"harmfulObject-particle.plist"];
        [self addChild:knife z:1 tag:knifeTag];
        [self scheduleUpdate];
    }
	return self;
}

- (CGSize) contentSize{
    
    return knife.contentSize;
}

-(void) update:(ccTime)delta
{   
    [self getChildByTag:knifeTag].rotation += 2;
}

+ (void)preloadSharedResources
{
	// TODO
}

+ (void)unloadSharedResources
{
	// TODO
}

-(void)damageLabel{
    CCLabelTTF *amount = [CCLabelTTF labelWithString:@"-1" fontName:@"Marker Felt" fontSize:20];
    amount.position = knife.position;
    [emitter addChild:amount];
}


- (void)collected
{   
    
    emitter.position = knife.position;
    emitter.autoRemoveOnFinish = YES;
    [self addChild:emitter];
    
    [self damageLabel];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"Oowh.caf"];
    [self removeChild:knife cleanup:YES];
    [self schedule: @selector(removeFromParent) interval:1];
}


-(void)removeFromParent{
    [[self gameLayerParent] removeChild:self cleanup:YES];
}
@end
