//
//  CCNode+Utilities.h
//  ClumsyChef
//
//  Created by Tong on 31/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCNode (Utilities)

// Set the current position 
//  and have it adjusted so that it doesn't look blur by avoiding fractional coordinates
- (void)setPositionSharp:(CGPoint)p;
- (void)sharpenCurrentPosition;

@end
