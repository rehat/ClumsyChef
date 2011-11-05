//
//  CHBackgroundLayer.h
//  ClumsyChef
//
//  Created by Tong on 24/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/**
 Background layer with parallax effect
 */
@interface CHBackgroundLayer : CCNode 


-(void)setWorldHeight:(CGFloat) height;
-(void)updatePull:(CGFloat)pull;
-(void)initWithInfo:(CGFloat) worldHeight;
@end
