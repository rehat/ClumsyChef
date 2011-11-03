//
//  CCLayer+Utilities.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Think Bulbs Ltd. All rights reserved.
//

#import "CCLayer+Utilities.h"


@implementation CCLayer (Utilities)

+ (CCScene *)layerAsScene
{
	CCScene *s = [CCScene node];
	CCLayer *l = [self node];
	[s addChild:l];
	return s;
}

@end
