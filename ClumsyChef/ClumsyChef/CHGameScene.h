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


// For debugging
- (void)setDebugMessage:(NSString *)format, ...;

// For HUD
- (void)pauseGame;

// For Pause layer / game lose layer
- (void)resumeGame;
- (void)restartLevel;
- (void)quitGame;

//Game States
-(void)showWin:(NSInteger)score;
-(void)showGameOver;
@end

