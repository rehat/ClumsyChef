//
//  CHHUDLayer.h
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "cocos2d.h"
#import "CHGameLibrary.h"


@interface CHHUDLayer : CCLayer

@property(nonatomic, assign) NSInteger numberOfLife;
@property(nonatomic, assign) NSInteger moneyAmount;

+ (id)nodeWithRequiredRecipeItems:(CCArray *)itemIDs;

//update HUD methods
- (void) setRecipeItemCollected:(NSString*)itemID;
- (void) updateScore:(NSInteger)amount;
- (void) updateLives;
- (void) updateHeight;

@end
