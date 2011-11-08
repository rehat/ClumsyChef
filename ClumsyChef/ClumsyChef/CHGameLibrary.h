//
//  CHGameLibrary.h
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CHGameLibrary : CCNode




+ (CHGameLibrary *)sharedGameLibrary;		// Singleton object

- (void)withFile:(NSString*)name;

-(NSInteger)getlives;
-(NSInteger)getStageHeight;
-(CCArray*)getRecipeItems;



@end
