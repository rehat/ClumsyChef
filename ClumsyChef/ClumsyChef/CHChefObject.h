//
//  CHChefObject.h
//  ClumsyChef
//
//  Created by Tong on 28/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CHGameObject.h"

/**
 * CHChefObject
 * Class for the chef object
 */
@interface CHChefObject : CHGameObject 

+ (id)node;

- (void)startAccelerating;
- (void)stopAccelerating;

- (void)setHorizontalAcceleration:(float)a;

@end
