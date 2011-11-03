//
//  CHGameLibrary.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHGameLibrary.h"



@interface CHRecipeItemInfo ()

@property(nonatomic, assign) CHRecipeItemID itemID;
@property(nonatomic, retain) NSString *spriteFilename;

@end

@implementation CHRecipeItemInfo
{
	CHRecipeItemID	_itemID;
	NSString		*_spriteFilename;
}

@synthesize itemID = _itemID;
@synthesize spriteFilename = _spriteFilename;

- (void)dealloc
{
	[_spriteFilename release];
	[super dealloc];
}

@end


@interface CHHarmfulItemInfo () 

@property(nonatomic, assign) CHHarmfulItemID itemID;
@property(nonatomic, retain) NSString *spriteFilename;

@end

@implementation CHHarmfulItemInfo
{
	CHHarmfulItemID	_itemID;
	NSString		*_spriteFilename;
}

@synthesize itemID = _itemID;
@synthesize spriteFilename = _spriteFilename;

- (void)dealloc
{
	[_spriteFilename release];
	[super dealloc];
}

@end


@interface CHStageInfo ()

@property(nonatomic, assign) CHStageID stageID;
@property(nonatomic, retain) NSString *stageName;
@property(nonatomic, retain) NSString *previewImageFilename;
@property(nonatomic, assign) NSInteger worldHeight;
@property(nonatomic, retain) NSString *backgroundFrontImageFilename;
@property(nonatomic, retain) NSString *backgroundBackImageFilename;

@end


@implementation CHStageInfo
{
	CHStageID		_stageID;
	NSString		*_stageName;
	NSString		*_previewImageFilename;
	NSInteger		_worldHeight;
	NSString		*_backgroundFrontImageFilename;
	NSString		*_backgroundBackImageFilename;

}

@synthesize stageID = _stageID;
@synthesize stageName = _stageName;
@synthesize previewImageFilename = _previewImageFilename;
@synthesize worldHeight = _worldHeight;
@synthesize backgroundFrontImageFilename = _backgroundFrontImageFilename;
@synthesize backgroundBackImageFilename = _backgroundBackImageFilename;

- (void)dealloc
{
	[_stageName release];
	[_previewImageFilename release];
	[_backgroundFrontImageFilename release];
	[_backgroundBackImageFilename release];
	[super dealloc];
}


@end

@implementation CHGameLibrary
{
	NSArray	*_recipeItemInfo;
	NSArray *_harmfulItemInfo;
	NSArray	*_stageInfo;
}

#pragma mark -
#pragma mark Private

- (NSMutableArray *)itemArrayWithcapacity:(NSUInteger)n
{
	NSMutableArray *items = [NSMutableArray arrayWithCapacity:n];
	NSNull *nullValue = [NSNull null];
	for (int i=0; i<n; i++) 
	{
		[items addObject:nullValue];
	}
	return items;
}

- (void)addReceiptItem:(CHRecipeItemID)itemID spriteFilename:(NSString *)filename to:(NSMutableArray *)items
{
	CHRecipeItemInfo *info = [[CHRecipeItemInfo alloc] init];
	info.itemID = itemID;
	info.spriteFilename = filename;
	[items replaceObjectAtIndex:(NSUInteger)itemID withObject:info];
	[info release];
}

- (void)addHarmfulItem:(CHHarmfulItemID)itemID spriteFilename:(NSString *)filename to:(NSMutableArray *)items
{
	CHHarmfulItemInfo *info = [[CHHarmfulItemInfo alloc] init];
	info.itemID = itemID;
	info.spriteFilename = filename;
	[items replaceObjectAtIndex:(NSUInteger)itemID withObject:info];
	[info release];
}

#pragma mark -
#pragma mark Constructor and Destructor


- (id)init
{
	if (self = [super init])
	{
		NSMutableArray *items = [self itemArrayWithcapacity:CHRecipeItemIDNumItems];
		
		// Recipe item info
		//-----------------------------------------------------------
		[self addReceiptItem:CHRecipeItemTest spriteFilename:@"gameObject-testIcon.png" to:items];
		
		//-----------------------------------------------------------
		_recipeItemInfo = [items retain];
		
		items = [self itemArrayWithcapacity:CHHarmfulItemIDNumItems];
		
		// Harmful item info and stage info
		//-----------------------------------------------------------
		[self addHarmfulItem:CHHarmfulItemTest spriteFilename:@"gameObject-testIcon.png" to:items];
		
		//-----------------------------------------------------------
		_recipeItemInfo = [items retain];
		
		items = [self itemArrayWithcapacity:CHStageIDNumItems];
		
		// Stage info
		//-----------------------------------------------------------
		// TODO
		//-----------------------------------------------------------
		_stageInfo = [items retain];
	}
	return self;
}

- (void)dealloc
{
	[_recipeItemInfo release];
	[_harmfulItemInfo release];
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

- (CHRecipeItemInfo *)recipeItemInfoWithID:(CHRecipeItemID)itemID
{
	return [_recipeItemInfo objectAtIndex:(NSUInteger)itemID];
}

- (CHHarmfulItemInfo *)harmfulItemInfoWithID:(CHHarmfulItemID)itemID
{	
	return [_harmfulItemInfo objectAtIndex:(NSUInteger)itemID];
}

- (CHStageInfo *)stageInfoWithID:(CHStageID)stageID
{
	NSInteger index = (NSInteger)stageID;
	return [_stageInfo objectAtIndex:index];
}


@end	
