//
//  CHHUDLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHHUDLayer.h"

@implementation CHHUDLayer
{
	NSInteger	_numberOfLife;
	NSInteger	_moneyAmount;
}

@synthesize numberOfLife = _numberOfLife;
@synthesize moneyAmount = _moneyAmount;


#pragma mark -
#pragma mark Constructor and destructor

- (id)initWithRequiredRecipeItems:(NSArray *)itemIDs
{
	if (self = [super init])
	{
		// Set up sprites, labels and pause button (CCMenu)
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

+ (id)nodeWithRequiredRecipeItems:(NSArray *)itemIDs
{
	return [[[self alloc] initWithRequiredRecipeItems:itemIDs] autorelease];
}


#pragma mark -
#pragma mark Public

- (void)setRecipeItemCollected:(CHRecipeItemID)itemID
{
	
}

- (BOOL)allItemsCollected
{
	return NO;
}

#pragma mark -
#pragma mark User interactions


@end
