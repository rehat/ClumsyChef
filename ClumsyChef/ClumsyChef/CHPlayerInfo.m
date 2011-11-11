//
//  CHPlayerInfo.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHPlayerInfo.h"

NSUInteger const CHPlayerInfoMaxNumHighScores = 10;
NSString* const CHPlayerInfoScoreEntryKeyPlyerName = @"playerName";
NSString* const CHPlayerInfoScoreEntryKeyScore = @"score";
static NSString* const kKeyNumClearedLevels = @"numClearedLevels";
static NSString* const kKeyHighScores = @"highScores";

@implementation CHPlayerInfo

- (id)init
{
	if (self = [super init])
	{
		// Set defaults
		NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
		NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:
									   [NSNumber numberWithUnsignedInteger:0], kKeyNumClearedLevels,
									   [NSArray array], kKeyHighScores, nil];
		[d registerDefaults:defaultValues];
	}
	return self;
}

+ (CHPlayerInfo *)sharedPlayerInfo
{
	static CHPlayerInfo *info = NULL;
	if (info == NULL)
	{
		info = [[CHPlayerInfo alloc] init];
	}
	return info;
}

- (NSUInteger)numClearedLevels
{
	NSNumber *n = [[NSUserDefaults standardUserDefaults] objectForKey:kKeyNumClearedLevels];
	return [n unsignedIntegerValue];
}

- (void)setNumClearedLevels:(NSUInteger)numClearedLevels
{
	NSNumber *n = [NSNumber numberWithUnsignedInteger:numClearedLevels];
	[[NSUserDefaults standardUserDefaults] setObject:n forKey:kKeyNumClearedLevels];
}

- (NSArray *)highScores
{
	NSArray *a = [[NSUserDefaults standardUserDefaults] objectForKey:kKeyHighScores];
	return a;
}

- (BOOL)canEnterHighScores:(NSUInteger)scores
{
	NSArray *a = self.highScores;
	if ([a count] < CHPlayerInfoMaxNumHighScores)
	{
		return YES;
	}
	else if (scores > [[[a objectAtIndex:CHPlayerInfoMaxNumHighScores-1] 
						valueForKey:CHPlayerInfoScoreEntryKeyScore] unsignedIntegerValue])
	{
		return YES;
	}
	return NO;
}

- (void)addHighScoreWithPlayerName:(NSString *)name scores:(NSUInteger)scores
{
	// No checking
	NSMutableArray *a = [NSMutableArray arrayWithArray:self.highScores];
	while ([a count] >= CHPlayerInfoMaxNumHighScores)
	{
		[a removeLastObject];
	}
	
	[a addObject:[NSDictionary dictionaryWithObjectsAndKeys:
				  name, CHPlayerInfoScoreEntryKeyPlyerName,
				  [NSNumber numberWithUnsignedInteger:scores], CHPlayerInfoScoreEntryKeyScore, nil]];
	// Sort it
	[a sortUsingComparator:^(id obj1, id obj2) {
		NSNumber *num1 = [obj1 objectForKey:CHPlayerInfoScoreEntryKeyScore];
		NSNumber *num2 = [obj2 objectForKey:CHPlayerInfoScoreEntryKeyScore];
		return [num1 compare:num2];
	}];
	
	// Set the new array
	[[NSUserDefaults standardUserDefaults] setObject:a forKey:kKeyHighScores];
}

@end
