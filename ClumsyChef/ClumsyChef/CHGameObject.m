//
//  CHGameObject.m
//  ClumsyChef
//
//  Created by Tong on 25/10/11.
//  Copyright 2011 Think Bulbs Ltd. All rights reserved.
//

#import "CHGameObject.h"


@implementation CHGameObject
{
	CHGameItemInfo *_representedItem;
	float _verticalSpeed;
	float _horizontalSpeed;
}

@synthesize representedItem = _representedItem;
@synthesize verticalSpeed = _verticalSpeed;
@synthesize horizontalSpeed = _horizontalSpeed;


- (id)initWithRepresentedItem:(CHGameItemInfo *)item
{
	if (self = [super init])
	{
		// TODO
	}
	return self;
}

- (void)update:(float)dt
{
	CGPoint p = self.position;
	p.x += _horizontalSpeed * dt;
	p.y -= _verticalSpeed * dt;
	
	self.position = p;
}

@end
