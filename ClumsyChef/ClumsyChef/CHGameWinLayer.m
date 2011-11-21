//
//  CHGameWinLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHGameWinLayer.h"
#import "CHGameScene.h"

@implementation CHGameWinLayer
{
    CCLabelBMFont	*_score;

}


- (id)initWithMoneyAmount:(NSInteger)score
{
	if (self = [super init])
	{
	
        
        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(160, 160, 160, 255)];
        [self addChild:bg];
        
        CCSprite *win = [CCSprite spriteWithFile:@"gameWin-title.png" ];
        CGSize screenSize = [[CCDirector sharedDirector]winSize];
        win.position = ccp(screenSize.width/2, screenSize.height - win.contentSize.height -100);
        [self addChild:win];
        
        CCSprite *description = [CCSprite spriteWithFile:@"gameWin-description.png"];
        description.position = ccp(screenSize.width/2, screenSize.height - win.contentSize.height - 100 - description.contentSize.height -100 );
        [self addChild:description];
        
        _score = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"$ %d", score]
                                            fntFile:@"gameWin-scoreFont.fnt"];
        _score.position = ccp(screenSize.width/2, screenSize.height - win.contentSize.height - 100 - description.contentSize.height -  100 - _score.contentSize.height  );
        [self addChild:_score];
        
        CCMenuItemImage *retry = [CCMenuItemImage itemFromNormalImage:@"gameEnd-restart.png" selectedImage:@"gameEnd-restart-high.png" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CHGameScene node]];}];
        
        CCMenuItemImage *quit = [CCMenuItemImage itemFromNormalImage:@"gameEnd-menu.png" selectedImage:@"gameEnd-menu-high.png" block:^(id sender) {
            [[CCDirector sharedDirector] popScene];}];
        
        
        
        
        
        
        CCMenu *menu = [CCMenu menuWithItems:retry,quit, nil];
        menu.position = ccp(screenSize.width/2, 50  );
        [menu alignItemsHorizontally];
        [self addChild:menu];

        
      	}
	return self;
}

+ (id)nodeWithMoneyAmount:(NSInteger)score
{
	return [[[self alloc] initWithMoneyAmount:score] autorelease];
}

- (void)showInNode:(CCNode *)node
{
	// run like "pop-up" animation to show this layer
}





@end
