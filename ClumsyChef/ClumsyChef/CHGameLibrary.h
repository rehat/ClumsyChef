//
//  CHGameLibrary.h
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
	CHGameObjectIDTestItem,
	
	//---------------------
	CHGameObjectIDNumItems,
} CHGameObjectID;



@interface CHGameItemInfo : NSObject 


@property(nonatomic, readonly) CHGameObjectID objectID;
@property(nonatomic, readonly, retain) NSString *spritePath;
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



@interface CHGameLibrary : NSObject


+ (CHGameLibrary *)sharedGameLibrary;		// Singleton object

- (CHGameItemInfo *)gameObjectInfoWithID:(CHGameObjectID)objectID;
- (CHStageInfo *)stageInfoWithID:(CHStageID)stageID;

@end
