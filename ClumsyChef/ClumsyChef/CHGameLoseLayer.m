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
		
        CCLabelTTF *lose = [CCLabelTTF labelWithString:@"YOU LOSE!" fontName:@"Marker Felt" fontSize:30];
        CGSize screenSize = [[CCDirector sharedDirector]winSize];
        lose.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:lose];
        
        CCMenuItemFont *item1 = [CCMenuItemFont itemFromString:@"Retry" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CHGameScene node]];}];  
        item1.fontSize = 16;
        
        CCMenuItemFont *item2 = [CCMenuItemFont itemFromString:@"Main Menu" block:^(id sender) {
            [[CCDirector sharedDirector] popScene];}];  
        item2.fontSize = 16;
        
        
        CCMenu *menu = [CCMenu menuWithItems:item1,item2, nil];
        [menu setPositionSharp:CHGetWinPointTL(screenSize.width/2, screenSize.height/2+40)];
        [menu alignItemsVertically];
        [self addChild:menu];
        
	}
	return self;
}





@end
