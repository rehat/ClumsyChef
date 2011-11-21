//
//  CHPauseLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHPauseLayer.h"
#import "CHGameScene.h"

@implementation CHPauseLayer

- (id)init
{
	if (self = [super init])
	{
		//CCSprite *chefLife = [CCSprite spriteWithFile:@"hud-chefLive.png"];
		//[chefLife setPositionSharp:ccp(250, 30)];
		//[self addChild:chefLife];
        
        
        CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:@"playbutton.png" 
                                                       selectedImage:@"playbuttonselected.png" 
                                                              target:self 
                                                            selector:@selector(resumeButtonPressed)];
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
        [menu setPositionSharp:ccp(250, 30)];
        [self addChild:menu];
        
        
		        
    }
	return self;
}

- (void)resumeButtonPressed
{
	// TODO
}



@end
