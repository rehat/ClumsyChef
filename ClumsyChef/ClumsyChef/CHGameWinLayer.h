//
//  CHGameWinLayer.h
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CHModalLayer.h"

@interface CHGameWinLayer : CHModalLayer 

+ (id)nodeWithLevelIndex:(NSUInteger)index moneyAmount:(NSUInteger)score;

@end
