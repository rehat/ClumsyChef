//
//  CHMenuButton.h
//  ClumsyChef
//
//  Created by Tong on 30/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CHMenuButton : CCMenuItemImage

// Use these three methods only!

/*
 This method looks for the normal image and highlighted image automatically:
 E.g. given "mainMenu-background", it looks for "mainMenu-background.png" & "mainMenu-background-high.png"
 */
+ (id)itemFromImageName:(NSString *)imageName
				  sound:(NSString *)soundName 
				 target:(id)r 
			   selector:(SEL)s;

+ (id)itemFromNormalImage:(NSString *)value 
			selectedImage:(NSString *)value2 
					sound:(NSString *)filename 
				   target:(id)r 
				 selector:(SEL)s;

+ (id)itemFromNormalImage:(NSString *)value 
			selectedImage:(NSString *)value2 
			disabledImage:(NSString *)value3 
					sound:(NSString *)filename 
				   target:(id)r 
				 selector:(SEL)s;

@end
