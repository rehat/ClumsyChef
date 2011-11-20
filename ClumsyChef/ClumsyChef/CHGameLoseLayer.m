//
//  CHGameLoseLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHGameLoseLayer.h"
#import "CHGameScene.h"

@implementation CHGameLoseLayer

- (id)init
{
	if (self = [super init])
	{
        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(160, 160, 160, 255)];
        [self addChild:bg];
        
        CCSprite *lose = [CCSprite spriteWithFile:@"gameOver-title.png" ];
        CGSize screenSize = [[CCDirector sharedDirector]winSize];
        lose.position = ccp(screenSize.width/2, screenSize.height/2 + 50);
        [self addChild:lose];
        
        
        CCMenuItemImage *retry = [CCMenuItemImage itemFromNormalImage:@"gameEnd-restart.png" selectedImage:@"gameEnd-restart-high.png" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CHGameScene node]];}];
        
        CCMenuItemImage *quit = [CCMenuItemImage itemFromNormalImage:@"gameEnd-quit.png" selectedImage:@"gameEnd-quit-high.png" block:^(id sender) {
            [[CCDirector sharedDirector] popScene];}];
        

        
        
     
        
        
        CCMenu *menu = [CCMenu menuWithItems:retry,quit, nil];
        menu.position = ccp(screenSize.width/2, screenSize.height/2 - lose.position.y/2  );
        //[menu setPositionSharp:CHGetWinPointTL(screenSize.width/2, screenSize.height/2+40)];
        [menu alignItemsHorizontally];
        [self addChild:menu];
        
	}
	return self;
}





@end
