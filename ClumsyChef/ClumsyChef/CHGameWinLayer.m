//
//  CHGameWinLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHGameWinLayer.h"


@implementation CHGameWinLayer


- (id)initWithMoneyAmount:(NSInteger)amount
{
	if (self = [super init])
	{
		
        CCLabelTTF *win = [CCLabelTTF labelWithString:@"YOU WIN!" fontName:@"Marker Felt" fontSize:30];
        CGSize screenSize = [[CCDirector sharedDirector]winSize];
        win.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:win];
        CCMenuItemFont *item = [CCMenuItemFont itemFromString:@"Main Menu" block:^(id sender) {
            [[CCDirector sharedDirector] popScene];}];                                                             
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
        [menu setPositionSharp:CHGetWinPointTL(40, 40)];

        
	}
	return self;
}

+ (id)nodeWithMoneyAmount:(NSInteger)amount
{
	return [[[self alloc] initWithMoneyAmount:amount] autorelease];
}

- (void)showInNode:(CCNode *)node
{
	// run like "pop-up" animation to show this layer
}





@end
