//
//  CHGameObject.m
//  ClumsyChef
//
//  Created by Tong on 25/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHGameObject.h"
#import "CHGameLibrary.h"

@implementation CHGameObject
{
	CHRecipeItemInfo *_representedItem;
	float _verticalSpeed;
	float _horizontalSpeed;
}

@synthesize verticalSpeed = _verticalSpeed;
@synthesize horizontalSpeed = _horizontalSpeed;

#pragma mark -
#pragma mark Constructor

- (void)dealloc
{
	[_representedItem release];
	[super dealloc];
}

#pragma mark -
#pragma mark APIs

- (void)update:(float)dt
{
	CGPoint p = self.position;
	p.x += _horizontalSpeed * dt;
	p.y -= _verticalSpeed * dt;
	
	self.position = p;
}

@end
