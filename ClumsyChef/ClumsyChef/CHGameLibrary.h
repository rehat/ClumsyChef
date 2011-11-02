//
//  CHGameLibrary.h
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHGameObject.h"

typedef enum
{
	CHGameObjectIDTestItem,
	CHGameObjectIDChef,
	
	//---------------------
	CHGameObjectIDNumItems,
} CHGameObjectID;



@interface CHGameItemInfo : NSObject 


@property(nonatomic, readonly) CHGameObjectID objectID;
@property(nonatomic, readonly) NSString *spritePath;
@property(nonatomic, readonly) int score;
// TODO: more information

@end


typedef enum 
{
	CHStageIDHamburger,
	CHStageIDSpaghetti,
	// More stage name
	
	//--------------------
	CHStageIDNumItems,
} CHStageID;

@interface CHStageInfo : NSObject 


// Background information
@property(nonatomic, readonly) CHStageID stageID;
@property(nonatomic, readonly) NSString *backgroundImagePath;
@property(nonatomic, readonly) int defaultTime;
@property(nonatomic, readonly) NSArray *receiptItems;

@end


@class CHGameObject;

/**
 * CHGameLibrary
 * A centralized place to look for:
 *    - stage info
 *    - receipt item info
 */
@interface CHGameLibrary : NSObject


+ (CHGameLibrary *)sharedGameLibrary;		// Singleton object

// Obtain game item info
- (CHGameItemInfo *)gameObjectInfoWithID:(CHGameObjectID)objectID;

// Obtain stage info
- (CHStageInfo *)stageInfoWithID:(CHStageID)stageID;

// Create new game object
- (CHGameObject *)gameObjectWithID:(CHGameObjectID)objectID;


@end
