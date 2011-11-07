//
//  CHGameLibrary.h
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>

/*-----------------------------------------------------------------
 Recipe Item
 -----------------------------------------------------------------*/
typedef enum
{
	CHRecipeItemTest,
	
	//---------------------
	CHRecipeItemIDNumItems,
} CHRecipeItemID;


@interface CHRecipeItemInfo : NSObject 

@property(nonatomic, readonly, assign) CHRecipeItemID itemID;
@property(nonatomic, readonly, retain) NSString *spriteFilename;

@end

/*-----------------------------------------------------------------
 Stage info
 -----------------------------------------------------------------*/

typedef enum 
{
	CHHarmfulItemTest,
	
	//--------------------
	CHHarmfulItemIDNumItems,
} CHHarmfulItemID;

@interface CHHarmfulItemInfo : NSObject 

@property(nonatomic, readonly, assign) CHHarmfulItemID itemID;
@property(nonatomic, readonly, retain) NSString *spriteFilename;

@end

/*-----------------------------------------------------------------
 Stage info
 -----------------------------------------------------------------*/
typedef enum 
{
	CHStageIDTestStage,
	// More stage name
	
	//--------------------
	CHStageIDNumItems,
} CHStageID;

@interface CHStageInfo : NSObject 

// Background information
@property(nonatomic, readonly, assign) CHStageID stageID;
@property(nonatomic, readonly, retain) NSString *stageName;
@property(nonatomic, readonly, retain) NSString *previewImageFilename;
@property(nonatomic, readonly, assign) NSInteger worldHeight;
@property(nonatomic, readonly, retain) NSString *backgroundFrontImageFilename;
@property(nonatomic, readonly, retain) NSString *backgroundBackImageFilename;

// TODO: More

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
- (CHRecipeItemInfo *)recipeItemInfoWithID:(CHRecipeItemID)itemID;
- (CHHarmfulItemInfo *)harmfulItemInfoWithID:(CHHarmfulItemID)itemID;

// Obtain stage info
- (CHStageInfo *)stageInfoWithID:(CHStageID)stageID;


@end
