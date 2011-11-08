//
//  CHChefObject.h
//  ClumsyChef
//
//  Created by Tong on 28/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/**
 * CHChefObject
 * Class for the chef object
 */
@interface CHChefObject : CCNode 

@property(nonatomic, assign) float verticalSpeed;	// +ve is downward
@property(nonatomic, assign) float horizontalSpeed;	// +ve is right

- (void)update:(float)dt;



- (void)startAccelerating;
- (void)stopAccelerating;

-(void) chefDamaged;

- (void)setHorizontalAcceleration:(float)a;

@end
