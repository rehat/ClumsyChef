//
//  CHItemObject.h
//  ClumsyChef
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class CHGameLayer;
@class CHGameScene;

/**
 * CHItemObject
 * Base class for all the items (everything but the chef) in the game layer
 */
@interface CHItemObject : CCNode
- (CHGameLayer *)gameLayerParent;
- (CHGameScene *)gameSceneParent;

// To be overridden by subclass
+ (void)preloadSharedResources;
+ (void)unloadSharedResources;

// To be overridden by subclass
// Typically, it play the sound, particle effect and remove itself from parent node
- (void)collected;

-(id)initWithFile:(NSString*)item;



@end
