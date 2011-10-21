//
//  CHPlayerInfo.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHPlayerInfo.h"

@implementation CHPlayerInfo

+ (CHPlayerInfo *)sharedPlayerInfo
{
	static CHPlayerInfo *info = NULL;
	if (info == NULL)
	{
		info = [[CHPlayerInfo alloc] init];
	}
	return info;
}

@end
