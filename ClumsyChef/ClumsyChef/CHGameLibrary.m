//
//  CHGameLibrary.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHGameLibrary.h"
//#import "CHGameObject.h"

@implementation CHGameItemInfo
{
	CHGameObjectID	_objectID;
	NSString		*_spritePath;
	int				_score;
}

@synthesize objectID = _objectID;
@synthesize spritePath = _spritePath;
@synthesize score = _score;

- (id)initWithObjectID:(CHGameObjectID)objectID 
			spritePath:(NSString *)spritePath
				 score:(int)score
{
	if (self = [super init])
	{
		_objectID = objectID;
		_spritePath = [spritePath retain];
		_score = score;
	}
	return self;
}

- (void)dealloc
{
	[_spritePath release];
	[super dealloc];
}

@end


@implementation CHStageInfo
{
	CHStageID		_stageID;
	NSString		*_backgroundImagePath;
	int				_defaultTime;
	NSArray		*_receiptItems;
}

@synthesize stageID = _stageID;
@synthesize backgroundImagePath = _backgroundImagePath;
@synthesize defaultTime = _defaultTime;
@synthesize receiptItems = _receiptItems;

- (id)initWithStageID:(CHStageID)stageID 
  backgroundImagePath:(NSString *)backgroundImagePath
		  defaultTime:(int)defaultTime
		 receiptItems:(NSArray *)receiptItems
{
	if (self = [super init])
	{
		_stageID = stageID;
		_backgroundImagePath = [backgroundImagePath retain];
		_defaultTime = defaultTime;
		_receiptItems = [receiptItems retain];
	}
	return self;
}

- (void)dealloc
{
	[_backgroundImagePath release];
	[_receiptItems release];
	[super dealloc];
}


@end

@implementation CHGameLibrary
{
	NSArray	*_itemInfo;
	NSArray	*_stageInfo;
}

#pragma mark -
#pragma mark Constructor and Destructor

- (void)addItemInfo:(CHGameObjectID)objectID spritePath:(NSString *)spritePath score:(int)score to:(NSMutableArray *)items
{
	CHGameItemInfo *info = [[CHGameItemInfo alloc] initWithObjectID:objectID spritePath:spritePath score:score];
	[items replaceObjectAtIndex:(NSUInteger)objectID withObject:info];
	[info release];
}

- (id)init
{
	if (self = [super init])
	{
		// Allocate the array for storing the items
		NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:CHStageIDNumItems];
		for (int i=0; i<CHStageIDNumItems; i++) 
		{
			[items addObject:[NSNull null]];
		}
		
		// Setup item info and stage info
		[self addItemInfo:CHGameObjectIDTestItem spritePath:@"gameObject-testIcon.png" score:0 to:items];
		[self addItemInfo:CHGameObjectIDChef spritePath:@"gameObject-testIcon.png" score:0 to:items];
		
		_itemInfo = items;
	}
	return self;
}

- (void)dealloc
{
	[_itemInfo release];
	[_stageInfo release];
	[super dealloc];
}

#pragma mark -
#pragma mark Public APIs

+ (CHGameLibrary *)sharedGameLibrary
{
	static CHGameLibrary *lib = NULL;
	if (lib == NULL) 
	{
		lib = [[CHGameLibrary alloc] init];
	}
	return lib;
}

- (CHGameItemInfo *)gameObjectInfoWithID:(CHGameObjectID)objectID
{
	NSInteger index = (NSInteger)objectID;
	return [_itemInfo objectAtIndex:index];
}

- (CHStageInfo *)stageInfoWithID:(CHStageID)stageID
{
	NSInteger index = (NSInteger)stageID;
	return [_stageInfo objectAtIndex:index];
}

// Create new game object
- (CHGameObject *)gameObjectWithID:(CHGameObjectID)objectID
{
	CHGameItemInfo *info = [self gameObjectInfoWithID:objectID];
	CHGameObject *object = [[[CHGameObject alloc] initWithRepresentedItem:info] autorelease];
	return object;
}

@end	
