//
//  CHRecipeItemObject.h
//  ClumsyChef
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CHGameLibrary.h"
#import "CHItemObject.h"

@interface CHRecipeItemObject : CHItemObject 

+ (id)nodeWithRecipeItemID:(CHRecipeItemID)itemID;

@end
