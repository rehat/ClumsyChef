//
//  CHStretchableSprite.m
//  ClumsyChef
//
//  Created by Tong on 19/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHStretchableSprite.h"


@implementation CHStretchableSprite
{
	NSUInteger	_leftCapWidth;
	NSUInteger	_topCapWidth;
}


- (void)addSpriteInRect:(CGRect)rect position:(CGPoint)p scale:(CGSize)scale
{
	CCSprite *s = [CCSprite spriteWithBatchNode:self rect:rect];
	s.anchorPoint = CGPointZero;
	s.position = p;
	s.scaleX = scale.width;
	s.scaleY = scale.height;
	[self addChild:s];
}

- (id)initWithFile:(NSString *)filename 
	  leftCapWidth:(NSUInteger)leftCapWidth
	   topCapWidth:(NSUInteger)topCapWidth
	   displaySize:(CGSize)size
{
	if (self = [super initWithFile:filename capacity:9])
	{
		self.anchorPoint = ccp(0.5f, 0.5f);
		_leftCapWidth = leftCapWidth;
		_topCapWidth = topCapWidth;
		
		self.contentSize = CGSizeMake(-1, -1);	// Force -setSpriteDisplaySize to do work
		[self setSpriteDisplaySize:size];
	}
	return self;
}

+ (id)stretchableSpriteWithFile:(NSString *)filename 
				   leftCapWidth:(NSUInteger)leftCapWidth 
					topCapWidth:(NSUInteger)topCapWidth
					displaySize:(CGSize)size
{
	return [[[self alloc] initWithFile:filename leftCapWidth:leftCapWidth topCapWidth:topCapWidth displaySize:size] autorelease];
}

- (void)setSpriteDisplaySize:(CGSize)size
{
	if (CGSizeEqualToSize(self.contentSize, size) || self.textureAtlas.texture == nil)
	{
		// Same size or no texture, do nothing
		return;
	}
	
	// Reset the contents
	[self removeAllChildrenWithCleanup:YES];
	self.contentSize = size;
	
	CGSize texSize = self.textureAtlas.texture.contentSize;
	
	if (_leftCapWidth == 0)
	{
		// No horizontal stretching
		size.width = texSize.width;
	}
	if (_topCapWidth == 0)
	{
		// No vertical stretching
		size.height = texSize.height;
	}

	if (size.width < texSize.width)
	{
		// We can't shrink the image by stretching, resort to scaling
		self.scaleX = size.width / texSize.width;
		size.width = texSize.width;
	}
	else
	{
		self.scaleX = 1;
	}
	
	if (size.height < texSize.height)
	{
		self.scaleY = size.height / texSize.height;
		size.height = texSize.height;
	}
	else
	{
		self.scaleY = 1;
	}
	
	// Texture UVs, top-left is the origin
	CGFloat x3 = _leftCapWidth + 1;
	CGFloat y3 = _topCapWidth + 1;
	CGFloat w3 = texSize.width - x3;
	CGFloat h3 = texSize.height - y3;
	
	CGRect r[9];
	r[0] = CGRectMake(0,				0,				_leftCapWidth,	_topCapWidth);
	r[1] = CGRectMake(_leftCapWidth,	0,				1,				_topCapWidth);
	r[2] = CGRectMake(x3,				0,				w3,				_topCapWidth);
	
	r[3] = CGRectMake(0,				_topCapWidth,	_leftCapWidth,	1);
	r[4] = CGRectMake(_leftCapWidth,	_topCapWidth,	1,				1);
	r[5] = CGRectMake(x3,				_topCapWidth,	w3,				1);
	
	r[6] = CGRectMake(0,				y3,				_leftCapWidth,	h3);
	r[7] = CGRectMake(_leftCapWidth,	y3,				1,				h3);
	r[8] = CGRectMake(x3,				y3,				w3,				h3);
	
	// Positons for sub-sprites, bottom-left is the origin
	CGFloat midXScale = size.width - _leftCapWidth - w3;
	CGFloat midYScale = size.height - _topCapWidth - h3;
	CGFloat px3 = size.width - w3;
	CGFloat py3 = size.height - _leftCapWidth;
	
	[self addSpriteInRect:r[0] position:CGPointMake(0, py3) scale:CGSizeMake(1, 1)];
	[self addSpriteInRect:r[1] position:CGPointMake(_leftCapWidth, py3) scale:CGSizeMake(midXScale, 1)];
	[self addSpriteInRect:r[2] position:CGPointMake(px3, py3) scale:CGSizeMake(1, 1)];
	
	[self addSpriteInRect:r[3] position:CGPointMake(0, h3) scale:CGSizeMake(1, midYScale)];
	[self addSpriteInRect:r[4] position:CGPointMake(_leftCapWidth, h3) scale:CGSizeMake(midXScale, midYScale)];
	[self addSpriteInRect:r[5] position:CGPointMake(px3, h3) scale:CGSizeMake(1, midYScale)];
	
	[self addSpriteInRect:r[6] position:CGPointMake(0, 0) scale:CGSizeMake(1, 1)];
	[self addSpriteInRect:r[7] position:CGPointMake(_leftCapWidth, 0) scale:CGSizeMake(midXScale, 1)];
	[self addSpriteInRect:r[8] position:CGPointMake(px3, 0) scale:CGSizeMake(1, 1)];	
}

@end
