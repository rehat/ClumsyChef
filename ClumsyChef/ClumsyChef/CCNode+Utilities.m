//
//  CCNode+Utilities.m
//  ClumsyChef
//
//  Created by Tong on 31/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CCNode+Utilities.h"


@implementation CCNode (Utilities)

- (void)setPositionSharp:(CGPoint)p
{
	CGSize s = self.contentSize;
	CGPoint anchor = self.anchorPoint;
	CGSize offsets = CGSizeMake(anchor.x * s.width, anchor.y * s.height);
	
	CGPoint bottomLeft = CGPointMake(floorf(p.x - offsets.width), 
									 floorf(p.y - offsets.height));
	CGPoint pp = CGPointMake(bottomLeft.x + offsets.width, bottomLeft.y + offsets.height);
	self.position = pp;
}

- (void)sharpenCurrentPosition
{
	[self setPositionSharp:self.position];
}

@end
