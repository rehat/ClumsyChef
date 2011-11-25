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
	CCSprite *_itemSprite;
    CCParticleSystemQuad *_sparkEmitter;
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
		
		_itemSprite = [CCSprite spriteWithFile:info.spriteFilename];
		
		NSDictionary *dict = [[CHSharedResHolder sharedResHolder] recipeParticleEffectDict];
		_sparkEmitter = [[[CCParticleSystemQuad alloc] initWithDictionary:dict] autorelease];
		
		//this is nasty :(
        _sparkEmitter.position = ccpAdd(_itemSprite.position, ccp(15, 20));
        _sparkEmitter.rotation = 180;  //based on the particle effect used.  Makes it look like it's falling (kinda);
		
		[_itemSprite addChild:_sparkEmitter z:-1];
        [self addChild:_itemSprite];
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
    return _itemSprite.contentSize;
}

- (void)collected
{
	// Remove the old particle effect
	[_sparkEmitter removeFromParentAndCleanup:YES];
	_sparkEmitter = nil;
	
	// Craete the particle effect
	NSDictionary *dict = [[CHSharedResHolder sharedResHolder] recipeCollectedParticleDict];
	CCParticleSystemQuad *e = [[[CCParticleSystemQuad alloc] initWithDictionary:dict] autorelease];
	e.position = CGPointZero;
    e.autoRemoveOnFinish = YES;
    [self addChild:e];
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"recipeItem-sound.caf"];
    [self removeChild:_itemSprite cleanup:YES];
	_itemSprite = nil;
    [self schedule: @selector(removeFromParent) interval:1.5];
}

-(void)removeFromParent
{
    [[self gameLayerParent] removeChild:self cleanup:YES];
}

@end
