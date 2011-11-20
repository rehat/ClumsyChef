//
//  CHHUDLayer.h
//  ClumsyChef
//
//  Created by Tong on 18/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CHHUDLayer : CCLayer

@property(nonatomic, assign) NSInteger numberOfLifes;
@property(nonatomic, assign) NSInteger moneyAmount;
@property(nonatomic, assign) float progress;

+ (id)nodeWithRequiredRecipeItems:(NSArray *)itemIDs 
					numberOfLifes:(NSInteger)numLifes 
					  moneyAmount:(NSInteger)amount;

+ (id)nodeForTesting;

- (void)setRecipeItemCollected:(NSString*)itemID;

@end
