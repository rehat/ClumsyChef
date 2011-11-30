//
//  CHGameLoseLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHGameLoseLayer.h"
#import "CHGameScene.h"
#import "SimpleAudioEngine.h"
#import "CHMenuButton.h"


@implementation CHGameLoseLayer

- (CHGameScene *)gameSceneParent
{
	CHGameScene *p = (CHGameScene *)self.parent;
	if ([p isKindOfClass:[CHGameScene class]])
		return p;
	return nil;
}

- (id)init
{
	if (self = [super initWithDimOpacity:CHModalLayerDefaultDimOpacity])
	{
		CGFloat screenCenterX = CHGetHalfWinWidth();
		
        CCSprite *lose = [CCSprite spriteWithFile:@"gameOver-title.png"];
        [lose setPositionSharp:ccp(screenCenterX, 290)];
        [self addChild:lose];
        
        CCMenuItemImage *retry = [CHMenuButton itemFromImageName:@"gameEnd-restart" 
														   sound:CHSoundButtonPress
														  target:self 
														selector:@selector(restartPressed:)];
        
        CCMenuItemImage *quit = [CHMenuButton itemFromImageName:@"gameEnd-menu" 
														  sound:CHSoundButtonPress
														 target:self
													   selector:@selector(menuPressed:)];

        CCMenu *menu = [CCMenu menuWithItems:retry, quit, nil];
        menu.position = ccp(screenCenterX, 52);
        [menu alignItemsHorizontally];
		
		// Make sure they are at sharp position after the alignment
		[retry sharpenCurrentPosition];
		[quit sharpenCurrentPosition];
		
        [self addChild:menu];  
	}
	return self;
}

- (void)onEnter
{
	[super onEnter];
	[[SimpleAudioEngine sharedEngine] playEffect:@"levelFail.caf"];
}

#pragma mark -
#pragma mark UI events

- (void)restartPressed:(id)sender
{
	CHGameScene *p = [self gameSceneParent];
	[self dismissModalLayer];
	[p restartLevel];
}

- (void)menuPressed:(id)sender
{
	[[self gameSceneParent] quitGame];
}


@end
