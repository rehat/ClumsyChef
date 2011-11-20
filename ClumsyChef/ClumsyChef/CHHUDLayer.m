//
//  CHHUDLayer.m
//  ClumsyChef
//
//  Created by Tong on 18/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHHUDLayer.h"
#import "CHGameLibrary.h"
#import "CHStretchableSprite.h"


static CGFloat const kItemWidth = 23;
static CGFloat const kItemGap = 12;
static NSInteger const kTagProgressBarNormal = 0;
static NSInteger const kTagProgressBarHigh = 1;
static float const kProgressHighThreshold = 0.9f;

/**
 * HUDItemSprite
 */
@interface HUDItemSprite : CCNode 

@property(nonatomic, assign) BOOL checkMarkHidden;

+ (id)nodeWithRecipeItem:(NSString *)itemID;

@end


@implementation HUDItemSprite
{
	CCSprite	*_checkMark;
}

- (id)initWithRecipeItem:(NSString *)itemID
{
	if (self = [super init])
	{
		CHRecipeItemInfo *info = [[CHGameLibrary sharedGameLibrary] recipeItemInfoWithName:itemID];
		CCSprite *itemSprite = [CCSprite spriteWithFile:info.spriteFilename];
		[itemSprite setPositionSharp:ccp(0, 0)];
		itemSprite.scale = 0.6969696969697f;
		[self addChild:itemSprite];
		
		_checkMark = [CCSprite spriteWithFile:@"hud-checkMark.png"];
		[_checkMark setPositionSharp:ccp(10, -4)];
		[self addChild:_checkMark];
		_checkMark.visible = NO;
	}
	return self;
}

+ (id)nodeWithRecipeItem:(NSString *)itemID
{
	return [[[HUDItemSprite alloc] initWithRecipeItem:itemID] autorelease];
}

- (BOOL)checkMarkHidden
{
	return !_checkMark.visible;
}

- (void)setCheckMarkHidden:(BOOL)hidden
{
	_checkMark.visible = !hidden;
}

@end


/*
 HUDProgressBar
 Assumption: Assume progress never decreases
 */
@interface HUDProgressBar : CCNode 
{
	float				_progress;
	CHStretchableSprite	*_progressFG;
}

@property(nonatomic, assign) float progress;

@end


@implementation HUDProgressBar

@synthesize progress = _progress;

- (CHStretchableSprite *)addBarWithFile:(NSString *)file width:(CGFloat)width
{
	CHStretchableSprite *bar;
	bar = [CHStretchableSprite stretchableSpriteWithFile:file
											leftCapWidth:1 
											 topCapWidth:0 
											 displaySize:CGSizeMake(width, 6)];
	bar.anchorPoint = CGPointZero;
	bar.position = CGPointZero;
	[self addChild:bar];
	
	return bar;
}

- (id)init
{
	if (self = [super init])
	{
		[self addBarWithFile:@"hud-progressBar-bg.png" width:CHGetWinWidth()];
		_progressFG = [self addBarWithFile:@"hud-progressBar-fg.png" width:0];
		_progressFG.tag = kTagProgressBarNormal;
	}
	return self;
}

- (void)setProgress:(float)progress
{
	_progress = clampf(progress, 0, 1);
	CGFloat width = floorf(_progress * CHGetWinWidth());
	if (_progress >= kProgressHighThreshold && _progressFG.tag != kTagProgressBarHigh)
	{
		// Change progress color
		[_progressFG removeFromParentAndCleanup:YES];
		_progressFG = [self addBarWithFile:@"hud-progressBar-fg-high.png" width:width];
	}
	else
	{
		// Just change the width
		[_progressFG setSpriteDisplaySize:CGSizeMake(width, 6)];
	}
}

@end

@implementation CHHUDLayer
{
	NSInteger	_numberOfLifes;
	NSInteger	_moneyAmount;
	
	NSDictionary	*_itemSprites;
	CCLabelBMFont	*_lifeLabel;
	CCLabelBMFont	*_moneyLabel;
	
	HUDProgressBar	*_progressBar;
	
}

@synthesize numberOfLifes = _numberOfLifes;
@synthesize moneyAmount = _moneyAmount;

#pragma mark -
#pragma mark Private

- (CGPoint)positionForItemAtIndex:(NSUInteger)index
{
	CGPoint p = CHGetWinPointTL(11 + index * (kItemWidth + kItemGap) + 0.5f * kItemWidth, 21);
	return p;
}

- (NSString *)stringForMoneyAmount:(NSInteger)amount
{
	return [NSString stringWithFormat:@"%d", amount];
}

#pragma mark -
#pragma mark Constructor and destructor


- (id)initWithRequiredRecipeItems:(NSArray *)itemIDs 
					numberOfLifes:(NSInteger)numLifes 
					  moneyAmount:(NSInteger)amount;
{
	if (self = [super init])
	{
        _numberOfLifes = numLifes;
        _moneyAmount = amount;

		//----------------------------------
		// Items
		//----------------------------------
		NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:[itemIDs count]];
		
		[itemIDs enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
			NSString *itemID = obj;
			HUDItemSprite *s = [HUDItemSprite nodeWithRecipeItem:itemID];
			CGPoint p = [self positionForItemAtIndex:index];
			[s setPositionSharp:p];
			[self addChild:s];
			
			[dict setObject:s forKey:itemID];
		}];
		
		_itemSprites = dict;
		
		//----------------------------------
		// life
		//----------------------------------
		CCSprite *chefLife = [CCSprite spriteWithFile:@"hud-chefLive.png"];
		[chefLife setPositionSharp:ccp(26, 30)];
		[self addChild:chefLife];
		
		_lifeLabel = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%d", _numberOfLifes]
											 fntFile:@"hud-numberFont.fnt"];
		_lifeLabel.anchorPoint = ccp(0, 0);
		[_lifeLabel setPositionSharp:ccp(37, 7)];
		[self addChild:_lifeLabel];
		
		//----------------------------------
		// Money
		//----------------------------------
		
		CCSprite *coin = [CCSprite spriteWithFile:@"hud-coin.png"];
		[coin setPositionSharp:ccp(72, 30)];
		[self addChild:coin];
		
		_moneyLabel = [CCLabelBMFont labelWithString:[self stringForMoneyAmount:_moneyAmount] 
											 fntFile:@"hud-numberFont.fnt"];
		_moneyLabel.anchorPoint = ccp(0, 0);
		[_moneyLabel setPositionSharp:ccp(84, 7)];
		[_moneyLabel setColor:ccc3Hex(0xface1f)];
		[self addChild:_moneyLabel];
		
		//----------------------------------
		// Progress bar
		//----------------------------------
		
		_progressBar = [HUDProgressBar node];
		[self addChild:_progressBar];
	}
	return self;
}

- (void)dealloc
{
	[_itemSprites release];
	[super dealloc];
}

#pragma mark -
#pragma mark Public

+ (id)nodeWithRequiredRecipeItems:(NSArray *)itemIDs numberOfLifes:(NSInteger)numLifes moneyAmount:(NSInteger)amount
{
	return [[[CHHUDLayer alloc] initWithRequiredRecipeItems:itemIDs 
											   numberOfLifes:numLifes 
												 moneyAmount:amount] autorelease];
}

+ (id)nodeForTesting
{
	NSArray *itemIDs = [NSArray arrayWithObjects:@"HotDog", @"Beef", @"Tomato", nil];
	CHHUDLayer *hud = [CHHUDLayer nodeWithRequiredRecipeItems:itemIDs 
												  numberOfLifes:3 
													moneyAmount:3000];
	[hud addChild:[CCLayerColor layerWithColor:ccc4Hex(0xc8c8c8)] z:-1];
	[hud setRecipeItemCollected:@"Tomato"];
	[hud setProgress:0.95f];
	return hud;
}

- (void)setNumberOfLifes:(NSInteger)numberOfLifes
{
	if (_numberOfLifes != numberOfLifes)
	{
		_numberOfLifes = numberOfLifes;
		[_lifeLabel setString:[NSString stringWithFormat:@"%d", _numberOfLifes]];
	}
}

- (void)setMoneyAmount:(NSInteger)moneyAmount
{
	if (_moneyAmount != moneyAmount)
	{
		_moneyAmount = moneyAmount;
		[_moneyLabel setString:[self stringForMoneyAmount:_moneyAmount]];
	}
}

- (float)progress
{
	return _progressBar.progress;
}

- (void)setProgress:(float)progress
{
	_progressBar.progress = progress;
}

- (void)setRecipeItemCollected:(NSString*)itemID
{
	HUDItemSprite *s = [_itemSprites objectForKey:itemID];
	s.checkMarkHidden = NO;
}

@end
