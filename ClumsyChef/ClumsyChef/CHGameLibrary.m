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
