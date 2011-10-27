//
//  CHGameLayer.h
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "cocos2d.h"
#import "CHGameScene.h"

@class CHGameObject;

@interface CHGameLayer : CCLayerColor

@end


@interface CHGameScene (CHGameLayerCalls)

- (void)handleChefCollisionWithItem:(CHGameObject *)object;

@end