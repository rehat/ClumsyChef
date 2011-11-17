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
#import "CHGameLibrary.h"
#import "CHSharedResHolder.h"


@implementation CHRecipeItemObject
{
	CCSprite *itemSprite;
    CCParticleSystemQuad *emitter;

    NSString *_itemID;
}

@synthesize itemID = _itemID;

#pragma mark -
#pragma mark Constructor and destructor


- (id)initWithItemID:(NSString *)itemID
{
	if (self = [super init])
	{
		_itemID = [itemID retain];
		CHRecipeItemInfo *info = [[CHGameLibrary sharedGameLibrary] recipeItemInfoWithName:_itemID];
		
		itemSprite = [CCSprite spriteWithFile:info.spriteFilename];
		
		NSDictionary *dict = [[CHSharedResHolder sharedResHolder] recipeParticleEffectDict];
		emitter = [[[CCParticleSystemQuad alloc] initWithDictionary:dict] autorelease];
		
		//this is nasty :(
        emitter.position = ccpAdd(itemSprite.position, ccp(15, 20));
        emitter.rotation = 180;  //based on the particle effect used.  Makes it look like it's falling (kinda);
		
		[itemSprite addChild:emitter z:-1];
        [self addChild:itemSprite];
	}
	return self;
}

- (void)dealloc
{
	[_itemID release];
	[super dealloc];
}

+ (id)nodeWithItemID:(NSString *)itemID
{
	return [[[self alloc] initWithItemID:itemID] autorelease];
}


- (CGSize)contentSize
{    
    return itemSprite.contentSize;
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
