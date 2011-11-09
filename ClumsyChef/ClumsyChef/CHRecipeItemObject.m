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
    CCParticleSystemQuad *emitter;

    
}

-(NSString*)itemID
{
    return ingredientLabel;
}

-(id)initWithFile:(NSString*)item{
    if (self = [super init]){
        
        ingredientLabel = item;
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSDictionary *ingredientSprites = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"Ingredients" ofType:@"plist"]];
        NSString *file = [ingredientSprites objectForKey:ingredientLabel];
        

        
        ingredient = [CCSprite spriteWithFile:file];
        emitter = [CCParticleSystemQuad particleWithFile:@"recipeItem-particle.plist"];
       
        //this is nasty :(
        emitter.position = ccpAdd(ingredient.position, ccp(15, 20));
        emitter.rotation = 180;  //based on the particle effect used.  Makes it look like it's falling (kinda);
        
        
        [ingredient addChild:emitter z:-1];
        [self addChild:ingredient];

        [ingredientSprites release];
    }
    return self;
}

+(id)node:(NSString*)ingredient{
    return [[[self alloc] initWithFile:ingredient] autorelease];

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
    [[SimpleAudioEngine sharedEngine] playEffect:@"recipeItem-sound.caf"];

    [[self gameLayerParent] removeChild:self cleanup:YES];
}

-(void)removeFromParent{
    [[self gameLayerParent] removeChild:self cleanup:YES];
}

@end
