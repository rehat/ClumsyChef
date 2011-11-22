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

- (CHGameScene *)gameSceneParent
{
	CHGameScene *p = (CHGameScene *)self.parent;
	if ([p isKindOfClass:[CHGameScene class]])
		return p;
	return nil;
}

- (id)initWithMoneyAmount:(NSInteger)score
{
	if (self = [super init])
	{
		CGFloat screenCenterX = CHGetHalfWinWidth();

        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(160, 160, 160, 255)];
        [self addChild:bg];
        
        CCSprite *win = [CCSprite spriteWithFile:@"gameWin-title.png" ];
        [win setPositionSharp:CHGetWinPointTL(screenCenterX, 85)];
        [self addChild:win];
        
        CCSprite *description = [CCSprite spriteWithFile:@"gameWin-description.png"];
		[description setPositionSharp:ccp(screenCenterX, 170)];
        [self addChild:description];
        
		NSString *scoreString = [NSString stringWithFormat:@"$%@", CHFormatDecimalNumber([NSNumber numberWithInteger:score])];
		_score = [CCLabelBMFont labelWithString:scoreString
										fntFile:@"gameWin-scoreFont.fnt"];
		[_score setPositionSharp:ccp(screenCenterX, 134)];
        [self addChild:_score];
        
		// Important: we don't use blocks because they retains (self), causing circular reference
		// and our layer will not be deallocated
        CCMenuItemImage *retry = [CCMenuItemImage itemFromNormalImage:@"gameEnd-restart.png" 
														selectedImage:@"gameEnd-restart-high.png" 
															   target:self 
															 selector:@selector(restartPressed:)];
        CCMenuItemImage *next = [CCMenuItemImage itemFromNormalImage:@"gameWin-next.png" 
													   selectedImage:@"gameWin-next-high.png" 
															  target:self 
															selector:@selector(nextPressed:)];
        CCMenuItemImage *quit = [CCMenuItemImage itemFromNormalImage:@"gameEnd-menu.png" 
													   selectedImage:@"gameEnd-menu-high.png" 
															  target:self 
															selector:@selector(menuPressed:)];
        
        CCMenu *menu = [CCMenu menuWithItems:retry, next, quit, nil];
        menu.position = ccp(screenCenterX, 50);
		[menu alignItemsHorizontally];
		
		// Make sure they are at sharp positons after the alignment
		[retry sharpenCurrentPosition];
		[next sharpenCurrentPosition];
		[quit sharpenCurrentPosition];
		
        [self addChild:menu];
	}
	return self;
}

+ (id)nodeWithMoneyAmount:(NSInteger)score
{
	return [[[self alloc] initWithMoneyAmount:score] autorelease];
}

#pragma mark -
#pragma mark UI events

- (void)restartPressed:(id)sender
{
	[[self gameSceneParent] restartLevel];
}

- (void)nextPressed:(id)sender
{
	[[self gameSceneParent] loadNextLevel];
}

- (void)menuPressed:(id)sender
{
	[[self gameSceneParent] quitGame];
}

@end
