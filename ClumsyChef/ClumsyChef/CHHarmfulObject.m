//
//  CHHarmfulObject.m
//  ClumsyChef
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHHarmfulObject.h"
#import "CHGameScene.h"

@implementation CHHarmfulObject
{
}

- (id)initWithHarmfulItemID:(CHHarmfulItemID)itemID
{
	CHHarmfulItemInfo *info = [[CHGameLibrary sharedGameLibrary] harmfulItemInfoWithID:itemID];
	if (self = [super initWithFile:info.spriteFilename])
	{
	}
	return self;
}

+ (id)nodeWithHarmfulItemID:(CHHarmfulItemID)itemID
{
	return [[[self alloc] initWithHarmfulItemID:itemID] autorelease];
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

- (void)didCollideWithChef
{
	[[self gameSceneParent] deductChefLife:1];
}
@end
