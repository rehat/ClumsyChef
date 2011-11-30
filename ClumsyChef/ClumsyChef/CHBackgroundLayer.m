//
//  CHBackgroundLayer.m
//  ClumsyChef
//
//  Created by Tong on 24/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHBackgroundLayer.h"
#import "CHGameLibrary.h"


@implementation CHBackgroundLayer
{
    CCSprite *_sideBuilding;
    CGFloat _worldHeight;
	CCSprite *_back;
}

- (id)initWithLevelIndex:(NSUInteger)levelIndex
{
	if ((self = [super init]))
	{
		CHLevelInfo *info = [[CHGameLibrary sharedGameLibrary] levelInfoAtIndex:levelIndex];
		_worldHeight = info.worldHeight;
		
		// Load the background
		_back = [CCSprite spriteWithFile:info.backgroundBackImage];
		_back.anchorPoint = ccp(0, 1);
		[self addChild:_back];
		
        //Side building in the foreground 
		_sideBuilding = [CCSprite spriteWithFile:info.backgroundSideBuildingImage
										   rect:CGRectMake(0, 0, 32, _worldHeight)]; 
        ccTexParams paramsSide = {GL_LINEAR, GL_LINEAR, GL_LINEAR, GL_REPEAT};
        [_sideBuilding.texture setTexParameters:&paramsSide];
		_sideBuilding.anchorPoint = ccp(1, 1);
        _sideBuilding.position = CHGetWinPointTR(0, 0);
        [self addChild:_sideBuilding];
	}
	
	return self;
}

+ (id)nodeWithLevelIndex:(NSUInteger)levelIndex
{
	return [[[CHBackgroundLayer alloc] initWithLevelIndex:levelIndex] autorelease];
}

- (void)setBackgroundOffset:(CGFloat)offset
{
	CGFloat y = -(offset - CHGetWinHeight());
	_sideBuilding.position = CHGetWinPointTR(0, y);
	
	CGFloat factor = (offset - CHGetWinHeight()) / (_worldHeight - CHGetWinHeight());
	y = factor * (-(_back.contentSize.height - CHGetWinHeight()));
	_back.position = CHGetWinPointTL(0, y);
}

@end
