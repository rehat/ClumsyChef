//
//  CHRecipeItemObject.m
//  ClumsyChef
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHRecipeItemObject.h"
#import "CHGameScene.h"

@implementation CHRecipeItemObject
{
	CHRecipeItemID	_itemID;
}

- (id)initWithRecipeItemID:(CHRecipeItemID)itemID
{
	CHRecipeItemInfo *info = [[CHGameLibrary sharedGameLibrary] recipeItemInfoWithID:itemID];
	if (self = [super initWithFile:info.spriteFilename])
	{
		_itemID = itemID;
		// TODO
	}
	return self;
}

+ (id)nodeWithRecipeItemID:(CHRecipeItemID)itemID
{
	return [[[self alloc] initWithRecipeItemID:itemID] autorelease];
}

- (void)dealloc
{
	[super dealloc];
}

+ (void)preloadSharedResources
{
	// TODO
}

+ (void)unloadSharedResources
{
	// TODO
}

- (void)collected
{
	[[self gameSceneParent] chefDidCollectRecipeItem:_itemID];
}

@end
