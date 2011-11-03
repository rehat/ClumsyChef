//
//  CHGameObject.h
//  ClumsyChef
//
//  Created by Tong on 25/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class CHRecipeItemInfo;

/**
 * CHGameObject
 * Base class for all the objects that appears in the game layer
 */
@interface CHGameObject : CCSprite

@property(nonatomic, assign) float verticalSpeed;	// +ve is downward
@property(nonatomic, assign) float horizontalSpeed;	// +ve is right

// Update the location, rotation
- (void)update:(float)dt;

@end
