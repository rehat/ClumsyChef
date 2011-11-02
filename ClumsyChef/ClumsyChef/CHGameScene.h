//
//  CHGameScene.h
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "cocos2d.h"
#import "CHGameLibrary.h"

@interface CHGameScene : CCScene


// For game layer to calls
- (void)chefDidCollideWithItem:(CHGameObject *)object;
- (void)worldOffsetDidChange:(CGFloat)offset;

@end

