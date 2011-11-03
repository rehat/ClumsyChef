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
		// Set up the sprites, labels, buttons
		// Set the contents according amount
		
		// 
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
