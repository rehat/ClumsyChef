//
//  CHRecipeItemObject.m
//  ClumsyChef
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHRecipeItemObject.h"
#import "CHGameScene.h"
#import "SimpleAudioEngine.h"


@implementation CHRecipeItemObject
{
	CCSprite *ingredient;
    NSString *ingredientLabel;
    
    
}

-(NSString*)itemID
{
    return ingredientLabel;
}




- (id)init
{
	if (self = [super init])
	{
        
        
        
    }
	return self;
}

-(void) buildMe:(NSString*)itemID{
    ingredientLabel = itemID;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *ingredientSprites = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"Ingredients" ofType:@"plist"]];
    
    NSString *file = [ingredientSprites objectForKey:ingredientLabel];
    
    NSLog(@"%@", file);

    ingredient = [CCSprite spriteWithFile:file];
    [self addChild:ingredient];
}




- (CGSize) contentSize{
    
    return ingredient.contentSize;
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
	//[[self gameSceneParent] chefDidCollectRecipeItem:_itemID];
    [self schedule: @selector(removeFromParent) interval:.8];
}

-(void)removeFromParent{
    [[self gameLayerParent] removeChild:self cleanup:YES];
}

@end
