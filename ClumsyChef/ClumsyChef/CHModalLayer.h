//
//  CHModalLayer.h
//  ClumsyChef
//
//  Created by Tong on 22/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CHModalLayer : CCLayer

- (id)initWithDimOpacity:(float)opacity;

- (void)showAsModalLayerInNode:(CCNode *)node;
- (void)dismissModalLayer;

@end

extern float const CHModalLayerDefaultDimOpacity;