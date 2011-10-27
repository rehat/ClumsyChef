//
//  CHGameLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHGameLayer.h"
#import "CHGameLibrary.h"
#import "CHUtilities.h"

@implementation CHGameLayer
{
	CHGameObject *_obj;
}

#pragma mark - 
#pragma mark Constructor and destructor

- (id)init	// TODO: Init with scene description
{
	if (self = [super initWithColor:ccc3To4(ccWHITE)])
	{
		_obj = [[[CHGameLibrary sharedGameLibrary] gameObjectWithID:CHGameObjectIDTestItem] retain];
		
		_obj.position = ccp(100, 300);
		_obj.verticalSpeed = 10.f;
		
		[self addChild:_obj];
		
		[self scheduleUpdate];
	}
	return self;
}

- (void)dealloc
{
	[_obj release];
}


#pragma mark -
#pragma mark xxx

- (void)update:(ccTime)dt
{
	[_obj update:dt];
}

@end
