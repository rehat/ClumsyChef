//
//  CHSharedResHolder.m
//  ClumsyChef
//
//  Created by Tong on 16/11/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHSharedResHolder.h"
#import "cocos2d.h"


static CHSharedResHolder *_sharedHolder = nil;

@implementation CHSharedResHolder
{
	NSDictionary *_coinParticleEffectDict;
	NSDictionary *_harmfulParticleEffectDict;
	NSDictionary *_recipeParticleEffectDict;
	NSDictionary *_recipeCollectedParticleDict;
}

@synthesize coinParticleEffectDict = _coinParticleEffectDict;
@synthesize harmfulParticleEffectDict = _harmfulParticleEffectDict;
@synthesize recipeParticleEffectDict = _recipeParticleEffectDict;
@synthesize recipeCollectedParticleDict = _recipeCollectedParticleDict;

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
	if (self = [super init])
	{
		NSString *filename = [[NSBundle mainBundle] pathForResource:@"coinObject-particle" 
															 ofType:@"plist"];
		_coinParticleEffectDict = [[NSDictionary alloc] initWithContentsOfFile:filename];
		
		filename = [[NSBundle mainBundle] pathForResource:@"harmfulObject-particle" ofType:@"plist"];
		_harmfulParticleEffectDict = [[NSDictionary alloc] initWithContentsOfFile:filename];
		
		filename = [[NSBundle mainBundle] pathForResource:@"recipeItem-particle" ofType:@"plist"];
		_recipeParticleEffectDict = [[NSDictionary alloc] initWithContentsOfFile:filename];
	
		filename = [[NSBundle mainBundle] pathForResource:@"recipeItem-collected-particle" ofType:@"plist"];
		_recipeCollectedParticleDict = [[NSDictionary alloc] initWithContentsOfFile:filename];
	}
	return self;
}

- (void)dealloc
{
	[_coinParticleEffectDict release];
	[_harmfulParticleEffectDict release];
	[_recipeParticleEffectDict release];
	[_recipeCollectedParticleDict release];
	[super dealloc];
}

+ (void)loadSharedResources
{
	NSAssert(_sharedHolder == nil, @"Previous shared resources not unloaded");
	_sharedHolder = [[CHSharedResHolder alloc] init];
}

+ (void)unloadSharedResources
{
	NSAssert(_sharedHolder != nil, @"Previous shared resources already unloaded");
	[_sharedHolder release];
	_sharedHolder = nil;
}

+ (CHSharedResHolder *)sharedResHolder
{
	return _sharedHolder;
}

@end
