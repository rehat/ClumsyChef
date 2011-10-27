//
//  CHUtilities.m
//  ClumsyChef
//
//  Created by Tong on 24/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHUtilities.h"


static CGSize winSize = {0, 0};
static CGPoint centerPoint = {0, 0};

void CHUtilitiesInit()
{
	winSize = [[CCDirector sharedDirector] winSize];
	centerPoint = CGPointMake(winSize.width * 0.5f, winSize.height * 0.5f);
}

CGSize CHGetWinSize()
{
	return winSize;
}

CGPoint CHGetWinCenterPoint()
{
	return centerPoint;
}

CGPoint CHGetWinPointTL(CGFloat x, CGFloat y)
{
	return CGPointMake(x, winSize.height - y);
}

CGPoint CHGetWinPointTR(CGFloat x, CGFloat y)
{
	return CGPointMake(winSize.width - x, winSize.height - y);
}

