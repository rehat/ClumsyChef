//
//  CHStretchableSprite.h
//  ClumsyChef
//
//  Created by Tong on 19/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CHStretchableSprite : CCSpriteBatchNode 

+ (id)stretchableSpriteWithFile:(NSString *)filename 
				   leftCapWidth:(NSUInteger)leftCapWidth 
					topCapWidth:(NSUInteger)topCapWidth
					displaySize:(CGSize)size;

- (void)setSpriteDisplaySize:(CGSize)size;

@end
