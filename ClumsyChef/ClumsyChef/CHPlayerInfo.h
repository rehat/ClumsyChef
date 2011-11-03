//
//  CHPlayerInfo.h
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHGameLibrary.h"


@interface CHPlayerInfo : NSObject

//@property(nonatomic, readonly) NSInteger	*numClearedLevels;
//@property(nonatomic, readonly) NSArray	*highestScores;	// NSDictionary {name, score}

+ (CHPlayerInfo *)sharedPlayerInfo;


@end
