//
//  CHGameLayer.h
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "cocos2d.h"
#import "CHGameLibrary.h"

@class CHGameObject;

@interface CHGameLayer : CCLayer

@property(nonatomic, assign) BOOL isPaused;

+ (id)nodeWithLevelIndex:(NSUInteger)levelIndex;

- (void)resetForLevelIndex:(NSUInteger)levelIndex;

- (void)stopBackgroundMusic;

@end


