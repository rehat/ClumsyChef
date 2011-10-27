//
//  CHGameObject.h
//  ClumsyChef
//
//  Created by Tong on 25/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//#import "CHGameLibrary.h"

@class CHGameItemInfo;

@interface CHGameObject : CCSprite


// The corresponding item in the game library represented by this game object
@property(nonatomic, readonly) CHGameItemInfo *representedItem;
@property(nonatomic, assign) float verticalSpeed;	// +ve is downward
@property(nonatomic, assign) float horizontalSpeed;	// +ve is right


- (id)initWithRepresentedItem:(CHGameItemInfo *)item;

// Update the location, rotation
- (void)update:(float)dt;

@end
