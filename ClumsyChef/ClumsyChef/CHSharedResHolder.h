//
//  CHSharedResHolder.h
//  ClumsyChef
//
//  Created by Tong on 16/11/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHSharedResHolder : NSObject

+ (void)loadSharedResources;
+ (void)unloadSharedResources;

+ (CHSharedResHolder *)sharedResHolder;		// Call only after calling +loadSharedResources

@property(nonatomic, readonly) NSDictionary *coinParticleEffectDict;
@property(nonatomic, readonly) NSDictionary *harmfulParticleEffectDict;
@property(nonatomic, readonly) NSDictionary *recipeParticleEffectDict;
@property(nonatomic, readonly) NSDictionary *recipeCollectedParticleDict;

@end
