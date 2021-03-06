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

@property(nonatomic) NSUInteger	numClearedLevels;
// NSDictionary {CHPlayerInfoScoreEntryKeyPlyerName, CHPlayerInfoScoreEntryKeyScore}
@property(nonatomic, readonly) NSArray		*highScores;
@property(nonatomic, assign) BOOL			frostModeEnabled;	// Not saved; Default is NO

+ (CHPlayerInfo *)sharedPlayerInfo;

- (NSUInteger)rankOfScore:(NSUInteger)score;
- (BOOL)canEnterHighScores:(NSUInteger)score;
- (void)addHighScoreWithPlayerName:(NSString *)name score:(NSUInteger)score;

#ifdef COCOS2D_DEBUG
+ (void)test;
#endif

@end

extern NSUInteger const CHPlayerInfoMaxNumHighScores;
extern NSString* const CHPlayerInfoScoreEntryKeyPlyerName;
extern NSString* const CHPlayerInfoScoreEntryKeyScore;
