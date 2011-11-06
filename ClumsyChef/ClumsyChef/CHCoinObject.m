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
}

//+ (id)node
//{
//	return [[[self alloc] initWithFile:@"gameObject-testIcon.png"] autorelease];
//}

- (id)init
{
	if (self = [super init])
	{
        coin = [CCSprite spriteWithFile:@"gameObject-testIcon.png"];
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

- (void)didCollideWithChef
{   
    [[SimpleAudioEngine sharedEngine] playEffect:@"coin.caf"];
	[[self gameSceneParent] addChefMoney:10];
    [[self gameLayerParent] removeChild:self cleanup:YES];
}
@end
