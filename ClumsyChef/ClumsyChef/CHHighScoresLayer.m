//
//  CHHighScoresLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHHighScoresLayer.h"
#import "CHMainMenuUtilities.h"
#import "CHPlayerInfo.h"


@implementation CHHighScoresLayer

- (id)init
{
	if (self = [super init])
	{
		CCSprite *bg = [CCSprite spriteWithFile:@"highScores-background.png"];
		[bg setPositionSharp:CHGetWinCenterPoint()];
		[self addChild:bg];
		
		// High scores entries
		NSString *fntFile = @"highScores-contentFont.fnt";
		
		CHPlayerInfo *info = [CHPlayerInfo sharedPlayerInfo];
		NSArray *entries = info.highScores;
		
		if ([entries count] == 0)
		{
			// No entry label
			CCLabelBMFont *label = [CCLabelBMFont labelWithString:@"No Records" 
														  fntFile:fntFile];
			[label setPositionSharp:CHGetWinPointTL(CHGetHalfWinWidth(), 150)];
			[self addChild:label];
		}
		else
		{
			CGFloat y = 132;
			for (NSDictionary *entry in entries) 
			{
				NSString *playerName = [entry objectForKey:CHPlayerInfoScoreEntryKeyPlyerName];
				NSNumber *score = [entry objectForKey:CHPlayerInfoScoreEntryKeyScore];
				
				// Name label
				CCLabelBMFont *nameLabel = [CCLabelBMFont labelWithString:playerName 
																  fntFile:fntFile];
				nameLabel.anchorPoint = ccp(0, 1);
				[nameLabel setPositionSharp:CHGetWinPointTL(41, y)];
				[self addChild:nameLabel];
				
				// Score label
				NSString *numStr = [NSString stringWithFormat:@"$%@", CHFormatDecimalNumber(score)];
				CCLabelBMFont *scoreLabel = [CCLabelBMFont labelWithString:numStr 
																   fntFile:fntFile];
				[scoreLabel setColor:ccc3Hex(0xfffdd7)];
				scoreLabel.anchorPoint = ccp(1, 1);
				[scoreLabel setPositionSharp:CHGetWinPointTR(41, y)];
				[self addChild:scoreLabel];
				
				y += 24;
			}
		}
		
		
		CCMenu *button = CHMenuMakeBackButton(ccp(CHGetHalfWinWidth(), 51), self, @selector(backButtonPressed:));
		[self addChild:button];
	}
	return self;
}

- (void)backButtonPressed:(id)sender
{
	CHMenuPopScene();
}

@end