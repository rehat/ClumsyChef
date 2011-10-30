//
//  CHBackgroundLayer.m
//  ClumsyChef
//
//  Created by Tong on 24/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHBackgroundLayer.h"


@implementation CHBackgroundLayer

-(id) init
{
	if ((self = [super init]))
	{
		screenSize = [[CCDirector sharedDirector] winSize];
        
        CCLayerColor *sky = [CCLayerColor layerWithColor:ccc4(127, 142, 251, 255)];
        [self addChild:sky];
        
        background1 = [CCSprite spriteWithFile:@"clouds.png"];
        background1.position = CGPointMake(screenSize.width - background1.contentSize.width/2,screenSize.height-background1.contentSize.height/2);
        [self addChild:background1];
        
        
        background2 = [CCSprite spriteWithFile:@"backB.png"];
        background2.position = CGPointMake(screenSize.width - background2.contentSize.width/2,screenSize.height-background2.contentSize.height/2);
        [self addChild:background2];
        sideBuilding = [CCSprite spriteWithFile:@"sideB.png"];
        sideBuilding.position = CGPointMake(screenSize.width - sideBuilding.contentSize.width/2, 0);
        [self addChild:sideBuilding];
        
        speed1 = 0.05f;
        speed2 = 4.0f;
        
        
        [self scheduleUpdate];
	}
	
	return self;
}

-(void) update:(ccTime)delta
{   
    CGPoint pos0 =  background1.position;
    pos0.y += speed1 + background1.zOrder;
    pos0.x += speed1 +.05f + background1.zOrder;
    background1.position = pos0;
    
    CGPoint pos1 =  background2.position;
    pos1.y += speed1 + background2.zOrder;
    background2.position = pos1;
    
    CGPoint pos2 =  sideBuilding.position;
    pos2.y += speed2 + sideBuilding.zOrder;
    sideBuilding.position = pos2;
    
    if (sideBuilding.position.y > sideBuilding.contentSize.height/2) {
        sideBuilding.position = ccp(screenSize.width - sideBuilding.contentSize.width/2, screenSize.height/2);
    }
    
    
}

@end
