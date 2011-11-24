//
//  CHModalLayer.m
//  ClumsyChef
//
//  Created by Tong on 22/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHModalLayer.h"
#import "CHTouchBlockingLayer.h"
#import "CHScreenshot.h"
#import "CHBlurImage.h"

float const CHModalLayerDefaultDimOpacity = 0.6f;

@implementation CHModalLayer
{
}

- (id)initWithDimOpacity:(float)opacity
{
	if (self = [super init])
	{
		// Take a screen shot and make it as a texture
		CGImageRef image = CHGetScreenShotImageForBlur();
		CGImageRef blurImage = CHCreateBlurImage(image, 3, 2);
		CCTexture2D *tex = [[CCTexture2D alloc] initWithImage:[UIImage imageWithCGImage:blurImage]];
		CGImageRelease(blurImage);
		
		// Add it as sprite
		CCSprite *screenSprite = [CCSprite spriteWithTexture:tex];
		
		// Scale it 
		CGSize winSizePx = [[CCDirector sharedDirector] winSizeInPixels];
		screenSprite.scaleX = ceilf(winSizePx.width / tex.pixelsWide);
		screenSprite.scaleY = ceilf(winSizePx.height / tex.pixelsHigh);
		[screenSprite setPositionSharp:CHGetWinCenterPoint()];
		[self addChild:screenSprite];
		
		[self addChild:[CHTouchBlockingLayer node]];
		CCLayerColor *dimLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, opacity * 255)];
		[self addChild:dimLayer];
	}
	return self;
}

- (void)showAsModalLayerInNode:(CCNode *)node
{
	[node addChild:self];
	// TODO: run like "pop-up" animation to show this layer
}

- (void)dismissModalLayer
{
	[self removeFromParentAndCleanup:YES];
}

@end
