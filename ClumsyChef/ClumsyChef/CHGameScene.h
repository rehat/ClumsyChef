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


// For game objects in game layer to call
- (void)addChefMoney:(NSInteger)amount;
- (void)deductChefLife:(NSInteger)numLife;

// For HUD
- (void)pauseGame;

@end

