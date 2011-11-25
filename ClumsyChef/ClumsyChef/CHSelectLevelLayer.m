//
//  CHSelectLevelLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHSelectLevelLayer.h"
#import "CHPlayerInfo.h"
#import "TestMenuLayer.h"
#import "CHUtilities.h"
#import "CHGameScene.h"
#import "CHGameLibrary.h"


// private methods are declared in this manner to avoid "may not respond to ..." compiler warnings
//@interface CHSelectLevelLayer (PrivateMethods)
//-(void) createMenu:(ccTime)delta;
//-(void) menuItem1Touched:(id)sender;
//-(void) menuItem2Touched:(id)sender;
//-(void) menuItem3Touched:(id)sender;
//-(void) menuItem4Touched:(id)sender;
//-(void) menuItem5Touched:(id)sender;
//-(void) menuItem6Touched:(id)sender;
//@end

@implementation CHSelectLevelLayer


- (id)init
{
	if (self = [super init])
	{
		CCSprite *bg = [CCSprite spriteWithFile:@"selectLevel-background.png"];
		[bg setPositionSharp:CHGetWinCenterPoint()];
		[self addChild:bg];
		
		//CHPlayerInfo *info = [CHPlayerInfo sharedPlayerInfo];
		
	
	}
	return self;
}




@end
