//
//  CHGameLibrary.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

//******** Stages.plist  FORMAT   ******
//______________________________________
//  Stage#  = key
//  item0 = (STRING) recipe name 
//  item1 = (NUMBER) stage height
//  item2 = (ARRAY) recipe item names which are keys to recipeObject's plist for sprites
//  item3 = (NUMBER) number of lives for this stage
//  item4 = (STRING) name of image file used by SelectLevelLayer

#import "CHGameLibrary.h"
#import "CHRecipeItemObject.h"


NSString* const kLevelPListFilename = @"gameLibrary-levels.plist";
NSString* const kRecipeItemPlistFilename = @"gameLibrary-recipeItems.plist";
NSString* const kHarmfulItemPlistFilename = @"gameLibrary-harmfulItems.plist";


@implementation CHGameLibrary
{
    NSString *stageKey;
    NSInteger lives;
    NSInteger stageHeight;
    CCArray *recipeItemKeys;
}


+(id)node:(NSString*)stage{
    return [[[self alloc] initWithFile:stage] autorelease];
    
}


-(NSInteger)getlives
{
    return lives;
}

-(NSInteger)getStageHeight
{
    return stageHeight;
}

-(CCArray*)getRecipeItems
{
//    CCArray *items = [[CCArray alloc] initWithCapacity:[recipeItemKeys  count]];
//    for (NSString *ingridient in recipeItemKeys) {
//        NSLog(@"%@", ingridient);
//    
//        //CHRecipeItemObject *recipeItem = [CHRecipeItemObject node];
//        CHRecipeItemObject *recipeItem = [CHRecipeItemObject node:ingridient ];
//        
//        //[recipeItem buildMe:ingridient];
//        [items addObject:recipeItem];
//    }
    
    
    return recipeItemKeys;
}


- (id)initWithFile:(NSString*)stage
{
    if(self = [super init]){
    stageKey = stage;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *stages = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"Stages" ofType:@"plist"]];
    
    
    //NSArray *keys = [[stages allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSArray *stageInfo = [stages objectForKey:stageKey];
    
    stageHeight = (NSInteger)[stageInfo objectAtIndex:1];
    recipeItemKeys =[[CCArray alloc] initWithNSArray:[stageInfo objectAtIndex:2]];
    lives = (NSInteger)[stageInfo objectAtIndex:3];
    
        [stages release];
    }
    return self;
}



                          
-(void)dealloc
{

	
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



@end	



@interface CHRecipeItemInfo ()

@property(nonatomic, retain) NSString *itemName;
@property(nonatomic, retain) NSString *spriteFilename;

@end

@implementation CHRecipeItemInfo
{
	NSString		*_itemName;
	NSString		*_spriteFilename;
}

@synthesize itemName = _itemName;
@synthesize spriteFilename = _spriteFilename;

- (void)dealloc
{
	[_itemName release];
	[_spriteFilename release];
	[super dealloc];
}

@end


@interface CHHarmfulItemInfo () 

@property(nonatomic, retain) NSString *itemName;
@property(nonatomic, retain) NSString *spriteFilename;

@end

@implementation CHHarmfulItemInfo
{
	NSString		*_itemName;
	NSString		*_spriteFilename;
}

@synthesize itemName = _itemName;
@synthesize spriteFilename = _spriteFilename;

- (void)dealloc
{
	[_itemName release];
	[_spriteFilename release];
	[super dealloc];
}

@end


@interface CHLevelInfo ()

@property(nonatomic, retain) NSString *levelName;
@property(nonatomic, retain) NSString *previewImage;
@property(nonatomic, assign) NSUInteger worldHeight;
@property(nonatomic, retain) NSString *backgroundSideBuildingImage;
@property(nonatomic, retain) NSString *backgroundBackImage;

@property(nonatomic, retain) NSArray *recipeItems;

@end


@implementation CHLevelInfo
{
	NSString		*_levelName;
	NSString		*_previewImage;
	NSUInteger		_worldHeight;
	NSString		*_backgroundSideBuildingImage;
	NSString		*_backgroundBackImage;
	
	NSArray			*_recipeItems;
}

@synthesize levelName = _levelName;
@synthesize previewImage = _previewImage;
@synthesize worldHeight = _worldHeight;
@synthesize backgroundSideBuildingImage = _backgroundSideBuildingImage;
@synthesize backgroundBackImage = _backgroundBackImage;
@synthesize recipeItems = _recipeItems;


- (void)dealloc
{
	[_levelName release];
	[_previewImage release];
	[_backgroundSideBuildingImage release];
	[_backgroundBackImage release];
	[_recipeItems release];
	[super dealloc];
}


@end

@implementation CHGameLibraryNew
{
	NSDictionary	*_recipeItemInfo;
	NSDictionary	*_harmfulItemInfo;
	NSArray			*_stageInfo;
}

#pragma mark -
#pragma mark Prviate

- (CHLevelInfo *)parseLevelInfoDict:(NSDictionary *)dict
{
	CHLevelInfo *info = [[[CHLevelInfo alloc] init] autorelease];
	info.levelName = [dict objectForKey:@"levelName"];
	info.previewImage = [dict objectForKey:@"previewImage"];
	info.worldHeight = [[dict objectForKey:@"worldHeight"] unsignedIntegerValue];
	info.backgroundSideBuildingImage = [dict objectForKey:@"backgroundSideBuildingImage"];
	info.backgroundBackImage = [dict objectForKey:@"backgroundBackImage"];
	info.recipeItems = [dict objectForKey:@"recipeItems"];
	
	return info;
}

- (NSArray *)parseLevelsArray:(NSArray *)array
{
	NSMutableArray *levels = [[NSMutableArray alloc] initWithCapacity:[array count]];
	
	for (NSDictionary *dict in array) 
	{
		CHLevelInfo *info = [self parseLevelInfoDict:dict];
		[levels addObject:info];
	}
	
	NSArray *a = [NSArray arrayWithArray:levels];
	[levels release];
	return a;
}

- (NSDictionary *)parseRecipeItemDict:(NSDictionary *)dict
{
	NSMutableDictionary *items = [[NSMutableDictionary alloc] initWithCapacity:[dict count]];
	
	[dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		CHRecipeItemInfo *info = [[CHRecipeItemInfo alloc] init];
		info.itemName = key;
		info.spriteFilename = obj;
		
		[items setObject:items forKey:key];
		[info release];
	}];
	
	NSDictionary *d = [NSDictionary dictionaryWithDictionary:items];
	[items release];
	return d;
}

- (NSDictionary *)parseHarmfulItemDict:(NSDictionary *)dict
{
	NSMutableDictionary *items = [[NSMutableDictionary alloc] initWithCapacity:[dict count]];
	
	[dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		CHHarmfulItemInfo *info = [[CHHarmfulItemInfo alloc] init];
		info.itemName = key;
		info.spriteFilename = obj;
		
		[items setObject:items forKey:key];
		[info release];
	}];
	
	NSDictionary *d = [NSDictionary dictionaryWithDictionary:items];
	[items release];
	return d;
}


#pragma mark -
#pragma mark Constructor and Destructor


- (id)init
{
	if (self = [super init])
	{
		// Level plist
		NSString *filename = [[NSBundle mainBundle] pathForResource:kLevelPListFilename ofType:@""];
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filename];
		NSAssert(array != nil, @"Level plist not found");
		
		_stageInfo = [[self parseLevelsArray:array] retain];
		[array release];
		
		// Recipe item plist
		filename = [[NSBundle mainBundle] pathForResource:kRecipeItemPlistFilename ofType:@""];
		NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filename];
		NSAssert(dict != nil, @"Recipe items plist not found");
		
		_recipeItemInfo = [[self parseRecipeItemDict:dict] retain];
		[dict release];
		
		// Harmful item plist
		filename = [[NSBundle mainBundle] pathForResource:kHarmfulItemPlistFilename ofType:@""];
		dict = [[NSDictionary alloc] initWithContentsOfFile:filename];
		NSAssert(dict != nil, @"Harmful item plist not found");
		
		_harmfulItemInfo = [[self parseHarmfulItemDict:dict] retain];
		[dict release];
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

+ (CHGameLibraryNew *)sharedGameLibrary
{
	static CHGameLibraryNew *lib = NULL;
	if (lib == NULL) 
	{
		lib = [[CHGameLibraryNew alloc] init];
	}
	return lib;
}

- (CHRecipeItemInfo *)recipeItemInfoWithName:(NSString *)itemName
{
	return [_recipeItemInfo objectForKey:itemName];
}

- (CHHarmfulItemInfo *)randomHarmfulItem
{
//	NSSet *keys = [_harmfulItemInfo allKeys];
//	NSUInteger index = (NSUInteger)(random() % [keys count]);
//	return [_harmfulItemInfo objectForKey:[
	return nil;
}

- (NSArray *)allLevelInfo
{
	return _stageInfo;
}

- (CHLevelInfo *)levelInfoWithName:(NSString *)levelName
{
	for (CHLevelInfo *info in _stageInfo)
	{
		if ([info.levelName isEqualToString:levelName])
		{
			return info;
		}
	}
	return nil;
}

+ (void)test
{
	CHGameLibraryNew *g = (CHGameLibraryNew *)[CHGameLibraryNew sharedGameLibrary];
	CHLevelInfo *info = [g levelInfoWithName:@"Test Level"];
	NSLog(@"info = %@", info);
}

@end	

