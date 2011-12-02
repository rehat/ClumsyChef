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
{
	BOOL _frostModeEnabled;
}
@synthesize frostModeEnabled = _frostModeEnabled;

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

- (NSUInteger)rankOfScore:(NSUInteger)score
{
	NSArray *a = self.highScores;
	NSUInteger rank = 0;
	
	for (NSDictionary *dict in a)
	{
		NSUInteger s = [[dict valueForKey:CHPlayerInfoScoreEntryKeyScore] unsignedIntegerValue];
		if (score >= s)
		{
			// Found the rank
			break;
		}
		rank++;
	}
	return rank;
}

- (BOOL)canEnterHighScores:(NSUInteger)score
{
	NSUInteger rank = [self rankOfScore:score];
	return (rank < CHPlayerInfoMaxNumHighScores);
}

- (void)addHighScoreWithPlayerName:(NSString *)name score:(NSUInteger)score
{
	NSUInteger rank = [self rankOfScore:score];
	
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
						  name, CHPlayerInfoScoreEntryKeyPlyerName,
						  [NSNumber numberWithUnsignedInteger:score], CHPlayerInfoScoreEntryKeyScore, nil];
	
	NSMutableArray *a = [NSMutableArray arrayWithArray:self.highScores];
	[a insertObject:dict atIndex:rank];
	
	// Remove excess object
	while ([a count] >= CHPlayerInfoMaxNumHighScores)
	{
		[a removeLastObject];
	}
	
	// Set the new array
	[[NSUserDefaults standardUserDefaults] setObject:a forKey:kKeyHighScores];
}

#pragma mark - 
#pragma mark Testing

#ifdef COCOS2D_DEBUG

- (void)resetPlayerInfo
{
	NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
	[d setObject:[NSNumber numberWithUnsignedInteger:0] forKey:kKeyNumClearedLevels];
	[d setObject:[NSArray array] forKey:kKeyHighScores];
}

+ (void)test
{
	CHPlayerInfo *p = [CHPlayerInfo sharedPlayerInfo];
	
	NSLog(@"Number of completed levels: %u", p.numClearedLevels);
	NSArray *a = p.highScores;
	NSLog(@"Number of high scores: %u", [a count]);
	
	for (NSDictionary *s in a) 
	{
		NSLog(@"Name: %@; Score: %@", 
			  [s objectForKey:CHPlayerInfoScoreEntryKeyPlyerName],
			  [s objectForKey:CHPlayerInfoScoreEntryKeyScore]);
	}
	
	if ([p canEnterHighScores:1000])
	{
		NSLog(@"Adding high score");
		[p addHighScoreWithPlayerName:@"Tong" score:1000];
	}
	else
	{
		NSLog(@"Score can't enter high scores list");
	}
}

#endif
@end
