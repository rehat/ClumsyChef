//
//  AppDelegate.h
//  ClumsyChef
//
//  Created by  on 19/10/11.
//  Copyright Team iUCI. 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
