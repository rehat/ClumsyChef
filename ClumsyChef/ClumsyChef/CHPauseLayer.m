//
//  CHPauseLayer.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHPauseLayer.h"
#import "CHGameScene.h"
//#import "CHModalLayer.h"

@implementation CHPauseLayer

CCSprite *pauseBackground;
CCMenu *resume;
CCMenu *restart;
CCMenu *quit;
CCMenu *sound;

- (id)init
{
	if (self = [super init])
	{
		//CCSprite *chefLife = [CCSprite spriteWithFile:@"hud-chefLive.png"];
		//[chefLife setPositionSharp:ccp(250, 30)];
		//[self addChild:chefLife];
        
        //Pause screen background image
        pauseBackground = [CCSprite spriteWithFile:@"pause-background.png"];
        [pauseBackground setPositionSharp:ccp(157, 250)];
        [self addChild:pauseBackground];
        
        //Pause screen resume button
        CCMenuItemImage *resumeImage = [CCMenuItemImage itemFromNormalImage:@"pause-resume.png"
                                                              selectedImage:@"pause-resume.png"
                                                                     target:self
                                                                   selector:@selector(resumeButtonPressed:)];
        resume = [CCMenu menuWithItems:resumeImage, nil];
        [resume setPositionSharp:ccp(105, 270)];
        [self addChild:resume];
        
        //Pause screen restart button
        CCMenuItemImage *restartImage = [CCMenuItemImage itemFromNormalImage:@"pause-restart.png"
                                                               selectedImage:@"pause-restart.png"
                                                                      target:self
                                                                    selector:@selector(restartButtonPressed:)];
        restart = [CCMenu menuWithItems:restartImage, nil];
        [restart setPositionSharp:ccp(210, 270)];
        [self addChild:restart];
        
        //Pause screen quit button
        CCMenuItemImage *quitImage = [CCMenuItemImage itemFromNormalImage:@"pause-quit.png"
                                                            selectedImage:@"pause-quit.png"
                                                                   target:self
                                                                 selector:@selector(quitButtonPressed:)];
        quit = [CCMenu menuWithItems:quitImage, nil];
        [quit setPositionSharp:ccp(105, 200)];
        [self addChild:quit];
        
        //Pause screen sound button
        CCMenuItemImage *soundImage = [CCMenuItemImage itemFromNormalImage:@"pause-sound.png"
                                                            selectedImage:@"pause-sound.png"
                                                                   target:self
                                                                 selector:@selector(resumeButtonPressed:)];
        sound = [CCMenu menuWithItems:soundImage, nil];
        [sound setPositionSharp:ccp(210, 200)];
        [self addChild:sound];
        
        
		        
    }
	return self;
}

- (CHGameScene *)gameSceneParent
{
	CHGameScene *p = (CHGameScene *)self.parent;
	if ([p isKindOfClass:[CHGameScene class]])
		return p;
	return nil;
}


- (void)resumeButtonPressed:(id)sender
{
	// TODO
    //[self removeChild:menu cleanup:true];
    //[self removeChild:pauseBackground cleanup:true];
    //[self removeChild:resume cleanup:true];
    //[self removeChild:restart cleanup:true];
    //[self removeChild:quit cleanup:true];
    [self dismissModalLayer];
    [[CCDirector sharedDirector] resume];
    //[[CCDirector sharedDirector] popScene];
    //[self remove

}


- (void)restartButtonPressed:(id)sender
{
    //CHGameScene *p = [self gameSceneParent];
    //[self removeChild:menu cleanup:true];
    //[self removeChild:pauseBackground cleanup:true];
    //[self removeChild:resume cleanup:true];
    //[self removeChild:restart cleanup:true];
    //[self removeChild:quit cleanup:true];
    [self dismissModalLayer];
    //[[CCDirector sharedDirector] resume];
	[[self gameSceneParent] restartLevel];
    
}

- (void)quitButtonPressed:(id)sender
{
    [[self gameSceneParent] quitGame];
}

- (void)soundButtonPressed:(id)sender
{
    
}



@end
