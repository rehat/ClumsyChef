//
//  CHMainMenuUtilities.h
//  ClumsyChef
//
//  Created by Tong on 24/11/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

CCMenu* CHMenuMakeBackButton(CGPoint position, id target, SEL selector);

void CHMenuPushScene(CCScene *scene);
void CHMenuPopScene();
