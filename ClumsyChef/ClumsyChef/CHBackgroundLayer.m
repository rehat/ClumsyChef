//
//  CHBackgroundLayer.m
//  ClumsyChef
//
//  Created by Tong on 24/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHBackgroundLayer.h"



@implementation CHBackgroundLayer
{
    CCSprite *clouds;
    CCSprite *background;
    CCSprite *sideBuilding;
    CCSprite *bottom;
    
    float speed1;
    float speed2;
    CGFloat worldHeight;
    CGFloat oldHeight;
    
    CGSize screenSize;
}

-(void)setWorldHeight:(CGFloat) height{
    
    worldHeight = height;
}


-(id) init
{
	if ((self = [super init]))
	{
		screenSize = [[CCDirector sharedDirector] winSize];
        oldHeight = 480;
        
        //Blue sky color
        CCLayerColor *sky = [CCLayerColor layerWithColor:ccc4(127, 142, 251, 255)];
        
        [self addChild:sky];
        
        //Moving clouds
        clouds = [CCSprite spriteWithFile:@"backgroundLayer-clouds.png" rect:CGRectMake(0, 0, screenSize.width*50, screenSize.height)];
        ccTexParams paramsClouds = {GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_LINEAR};
        [clouds.texture setTexParameters:&paramsClouds];
        clouds.position = CGPointMake(screenSize.width - clouds.contentSize.width/2,screenSize.height-clouds.contentSize.height/2);
        [self addChild:clouds];
        
        //Main Background
        background = [CCSprite spriteWithFile:@"background-empire.png"];
        background.position = CGPointMake(background.contentSize.width/2,background.contentSize.height/2);
        [self addChild:background];
        
        //Side building in the foreground 
        sideBuilding = [CCSprite spriteWithFile:@"backgroundLayer-sideBuilding.png" rect:CGRectMake(0, 0, 32, screenSize.height *300)]; 
        ccTexParams paramsSide = {GL_LINEAR, GL_LINEAR, GL_LINEAR, GL_REPEAT};
        [sideBuilding.texture setTexParameters:&paramsSide];
        sideBuilding.position = CGPointMake(screenSize.width - sideBuilding.contentSize.width/2, 0);
        [self addChild:sideBuilding];
        
        
        //Bottom game win scene
        //bottom = [CCSprite spriteWithFile:@"backgroundLayer-bottom.png"];
        
        
        //TODO:  Need to find out how game win will occur 1) once reached max stage height and all items collected or
        //                                                2) once all items are collected regardless of stage height.
        
        
        
        
        speed1 = 0.07f;
        speed2 = 4.0f;
        
        
        [self scheduleUpdate];
	}
	
	return self;
}

-(void) updatePull:(CGFloat)pull {
        
    CGFloat pullUp = pull - oldHeight;
    CGPoint pos2 =  sideBuilding.position;
    pos2.y += pullUp + sideBuilding.zOrder;
    oldHeight = pull;

    
    sideBuilding.position = pos2;
    
}



-(void) update:(ccTime)delta
{   
    
    
    CGPoint pos0 =  clouds.position;
    //pos0.y += speed1 + clouds.zOrder;
    pos0.x += speed1 +.05f + clouds.zOrder;
    clouds.position = pos0;
    
//    CGPoint pos1 =  background.position;
//    pos1.y += speed1 + background.zOrder;
//    background.position = pos1;
    
    //[self showGround];
    
    
}

//-(void)showGround{

//}

@end
