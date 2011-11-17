//
//  CHItemObject.m
//  ClumsyChef
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHItemObject.h"
#import "CHGameLayer.h"
#import "CHGameScene.h"


@implementation CHItemObject

- (CHGameLayer *)gameLayerParent
{
	CHGameLayer *p = (CHGameLayer *)[self parent];
	if ([p isKindOfClass:[CHGameLayer class]])
	{
		return p;
	}
	return nil;
}

- (CHGameScene *)gameSceneParent
{
	CHGameScene *p = (CHGameScene *)[[self parent] parent];
	if ([p isKindOfClass:[CHGameScene class]])
	{
		return p;
	}
	return nil;	
}

- (void)collected
{
}

@end
