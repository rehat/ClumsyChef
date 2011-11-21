//
//  CHGameWinLayer.h
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CHGameWinLayer : CCLayer 


+ (id)nodeWithMoneyAmount:(NSInteger)score;

- (void)showInNode:(CCNode *)node;

@end
