//
//  CHGameWinLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHGameWinLayer.h"
#import "CHGameScene.h"
#import "CHGameLibrary.h"
#import "CHPlayerInfo.h"
#import "SimpleAudioEngine.h"


static NSString* const kDefaultPlayerName = @"Player1";


@interface CHGameWinLayer () <UIAlertViewDelegate>
@end


@implementation CHGameWinLayer
{
    NSUInteger	_score;
	CCMenuItemImage	*_nextButton;
}

- (CHGameScene *)gameSceneParent
{
	CHGameScene *p = (CHGameScene *)self.parent;
	if ([p isKindOfClass:[CHGameScene class]])
		return p;
	return nil;
}

- (id)initWithLevelIndex:(NSUInteger)index moneyAmount:(NSUInteger)score
{
	if (self = [super initWithDimOpacity:CHModalLayerDefaultDimOpacity])
	{
		_score = score;
		CGFloat screenCenterX = CHGetHalfWinWidth();

        CCSprite *win = [CCSprite spriteWithFile:@"gameWin-title.png" ];
        [win setPositionSharp:CHGetWinPointTL(screenCenterX, 85)];
        [self addChild:win];
        
        CCSprite *description = [CCSprite spriteWithFile:@"gameWin-description.png"];
		[description setPositionSharp:ccp(screenCenterX, 170)];
        [self addChild:description];
        
		// Finish image (recipe item image)
		CHLevelInfo *levelInfo = [[CHGameLibrary sharedGameLibrary] levelInfoAtIndex:index];
		CCSprite *finishImage = [CCSprite spriteWithFile:levelInfo.finishImage];
		[finishImage setPositionSharp:ccp(screenCenterX, 274)];
		[self addChild:finishImage];
		
		// Score label
		NSString *scoreString = [NSString stringWithFormat:@"$%@", CHFormatDecimalNumber([NSNumber numberWithInteger:score])];
		CCLabelBMFont *scoreLabel = [CCLabelBMFont labelWithString:scoreString
										fntFile:@"gameWin-scoreFont.fnt"];
		[scoreLabel setPositionSharp:ccp(screenCenterX, 134)];
        [self addChild:scoreLabel];
        
		// Important: we don't use blocks because they retains (self), causing circular reference
		// and our layer will not be deallocated
        CCMenuItemImage *retry = [CCMenuItemImage itemFromNormalImage:@"gameEnd-restart.png" 
														selectedImage:@"gameEnd-restart-high.png" 
															   target:self 
															 selector:@selector(restartPressed:)];
        CCMenuItemImage *next = [CCMenuItemImage itemFromNormalImage:@"gameWin-next.png" 
													   selectedImage:@"gameWin-next-high.png"
													   disabledImage:@"gameWin-next-disabled.png"
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
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"levelWin.caf"];

		_nextButton = next;
	}
	return self;
}

+ (id)nodeWithLevelIndex:(NSUInteger)index moneyAmount:(NSUInteger)score
{
	return [[[self alloc] initWithLevelIndex:index moneyAmount:score] autorelease];
}

- (void)onEnter
{
	[super onEnter];
	// Enable/disable the next image
	[_nextButton setIsEnabled:[[self gameSceneParent] hasNextLevel]];
}

#pragma mark -
#pragma mark UI events

- (void)restartPressed:(id)sender
{
	CHGameScene *p = [self gameSceneParent];
	[self dismissModalLayer];
	[p restartLevel];
}

- (void)nextPressed:(id)sender
{
	CHGameScene *p = [self gameSceneParent];
	[self dismissModalLayer];
	[p loadNextLevel];
}

- (void)menuPressed:(id)sender
{
	CHPlayerInfo *info = [CHPlayerInfo sharedPlayerInfo];
	if ([info canEnterHighScores:_score])
	{
		NSUInteger rank = [info rankOfScore:_score];
		NSString *title = [NSString stringWithFormat:@"#%u in High Score", rank+1];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
														message:@"Congratulations!\nPlease enter your name:" 
													   delegate:self 
											  cancelButtonTitle:@"No Thanks" 
											  otherButtonTitles:@"Enter", nil];
		alert.alertViewStyle = UIAlertViewStylePlainTextInput;
		[[alert textFieldAtIndex:0] setText:kDefaultPlayerName];
		[alert show];
		[alert release];
	}
	else
	{
		[[self gameSceneParent] quitGame];
	}
}

#pragma mark -
#pragma mark UIAlertViewDelegate
							  
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex != alertView.cancelButtonIndex)
	{
		NSString *text = [[alertView textFieldAtIndex:0] text];
		// Set the name to default one if users inputs nothing
		text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		if ([text length] == 0)
		{
			text = kDefaultPlayerName;
		}
		CHPlayerInfo *info = [CHPlayerInfo sharedPlayerInfo];
		[info addHighScoreWithPlayerName:text score:_score];
	}
	[[self gameSceneParent] quitGame];
}

@end

