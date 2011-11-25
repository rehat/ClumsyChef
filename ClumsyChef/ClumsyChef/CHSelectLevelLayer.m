//
//  CHSelectLevelLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHSelectLevelLayer.h"
#import "CHPlayerInfo.h"
#import "CHGameScene.h"
#import "CHGameLibrary.h"
#import "CHMainMenuUtilities.h"


static CGFloat const kX0 = 67;
static CGFloat const kY0 = 154;
static CGFloat const kXSpacing = 93;
static CGFloat const kYSpacing = 110;


@implementation CHSelectLevelLayer

#pragma mark -
#pragma mark Private

- (CGPoint)positionForItemInRow:(NSUInteger)row col:(NSUInteger)col
{
	return CHGetWinPointTL(kX0 + col * kXSpacing, kY0 + row * kYSpacing);
}

- (NSString *)filenameForHighImage:(NSString *)filename
{
	// E.g. given recipeItem-xxx.png
	// Return reciptItem-xxx-high.png
	NSString *ext = [filename pathExtension];
	NSString *name = [filename stringByDeletingPathExtension];
	NSString *result = [NSString stringWithFormat:@"%@-high.%@", name, ext];
	return result;
}

#pragma mark -
#pragma mark Constructor 

- (id)init
{
	if (self = [super init])
	{
		CCSprite *bg = [CCSprite spriteWithFile:@"selectLevel-background.png"];
		[bg setPositionSharp:CHGetWinCenterPoint()];
		[self addChild:bg];
		
		CHPlayerInfo *info = [CHPlayerInfo sharedPlayerInfo];
		info.numClearedLevels = 5;
		CHGameLibrary *lib = [CHGameLibrary sharedGameLibrary];
		NSUInteger numClearedLevels = info.numClearedLevels;
		NSUInteger numLevels = [lib numberOfLevels];
		
		for (NSUInteger i = 0; i < numLevels; i++) {
			if (i <= numClearedLevels) {
				// For cleared stages
				CHLevelInfo *levelInfo = [lib levelInfoAtIndex:i];
				
				CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:levelInfo.previewImage 
															   selectedImage:[self filenameForHighImage:levelInfo.previewImage]
																	  target:self 
																	selector:@selector(itemPressed:)];
				item.tag = i;
				[item setPositionSharp:[self positionForItemInRow:i/3 col:i%3]];
				
				CCMenu *menu = [CCMenu menuWithItems:item, nil];
				menu.anchorPoint = CGPointZero;
				menu.position = CGPointZero;
				[self addChild:menu];
			}
			else {
				// For levels not cleared
				CCSprite *placeHolder = [CCSprite spriteWithFile:@"selectLevel-locked.png"];
				[placeHolder setPositionSharp:[self positionForItemInRow:i/3 col:i%3]];
				
				[self addChild:placeHolder];
			}
		}
	
		// Back button
		CCMenu *button = CHMenuMakeBackButton(ccp(CHGetHalfWinWidth(), 35), 
											  self, @selector(backButtonPressed:));
		[self addChild:button];
	}
	return self;
}

#pragma mark -
#pragma mark UI events
					
- (void)itemPressed:(id)sender
{
	CCNode *item = sender;
	NSUInteger levelIndex = item.tag;
	CHGameScene *gs = [CHGameScene nodeWithLevelIndex:levelIndex];
	[[CCDirector sharedDirector] popScene];
	[[CCDirector sharedDirector] pushScene:gs];
}

- (void)backButtonPressed:(id)sender
{
	[[CCDirector sharedDirector] popScene];
}
@end
