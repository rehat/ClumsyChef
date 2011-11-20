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
static NSNumberFormatter *formatter = nil;

void CHUtilitiesInit()
{
	winSize = [[CCDirector sharedDirector] winSize];
	centerPoint = CGPointMake(winSize.width * 0.5f, winSize.height * 0.5f);
	formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
}

CGSize CHGetWinSize()
{
	return winSize;
}

CGFloat CHGetWinHeight()
{
	return winSize.height;
}

CGFloat CHGetWinWidth()
{
	return winSize.width;
}

CGFloat CHGetHalfWinWidth()
{
	return winSize.width * 0.5f;
}

CGFloat CHGetHalfWinHeight()
{
	return winSize.height * 0.5f;
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

CGPoint CHGetWinPointBR(CGFloat x, CGFloat y)
{
	return CGPointMake(winSize.width - x, y);
}
#pragma mark -
#pragma mark Number utilities

NSString* CHFormatDecimalNumber(NSNumber *num)
{
	NSString *s = [formatter stringFromNumber:num];
	return s;
}