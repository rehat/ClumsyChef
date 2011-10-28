//
//  CHChefObject.h
//  ClumsyChef
//
//  Created by Tong on 28/10/11.
//  Copyright 2011 Think Bulbs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CHGameObject.h"


@interface CHChefObject : CHGameObject 

+ (CHChefObject *)chefObject;

- (void)startAccelerating;
- (void)stopAccelerating;

- (void)setHorizontalAcceleration:(float)a;

@end
