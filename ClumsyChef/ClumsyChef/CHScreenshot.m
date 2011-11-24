//
//  CHScreenshot.m
//  ClumsyChef
//
//  Created by Tong on 23/11/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHScreenshot.h"

#pragma mark -
#pragma mark Take screenshot as Image

CGImageRef CHGetScreenShotImage()
{
    CCDirector *director = [CCDirector sharedDirector];
	CGSize displaySize	= [director displaySizeInPixels];
	CGSize winSize	= [director winSizeInPixels];
	
	// Create buffer for pixels
	GLuint bufferLength = displaySize.width * displaySize.height * 4;
	GLubyte* buffer = (GLubyte*)malloc(bufferLength);
	
	// Read Pixels from OpenGL
	glReadPixels(0, 0, displaySize.width, displaySize.height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
	
	// Make data provider with data.
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer, bufferLength, NULL);
	
	// Configure image
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGImageRef iref = CGImageCreate(displaySize.width, displaySize.height, 8, 32, displaySize.width * 4, colorSpaceRef, kCGBitmapByteOrderDefault, provider, NULL, NO, kCGRenderingIntentDefault);
	
    // Create buffer for output image
	uint32_t* pixels = (uint32_t*)malloc(winSize.width * winSize.height * 4);
	CGContextRef context = CGBitmapContextCreate(pixels, winSize.width, winSize.height, 8, winSize.width * 4, colorSpaceRef, kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Big);
	
    // Transform
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
    CGContextTranslateCTM(context, 0, displaySize.height);
	CGContextScaleCTM(context, 1, -1);
	
	switch ([director deviceOrientation])
	{
		case kCCDeviceOrientationPortrait: break;
		case kCCDeviceOrientationPortraitUpsideDown:
			CGContextRotateCTM(context, CC_DEGREES_TO_RADIANS(180));
			CGContextTranslateCTM(context, -displaySize.width, -displaySize.height);
			break;
		case kCCDeviceOrientationLandscapeLeft:
			CGContextRotateCTM(context, CC_DEGREES_TO_RADIANS(-90));
			CGContextTranslateCTM(context, -displaySize.height, 0);
			break;
		case kCCDeviceOrientationLandscapeRight:
			CGContextRotateCTM(context, CC_DEGREES_TO_RADIANS(90));
			CGContextTranslateCTM(context, displaySize.height-displaySize.width, -displaySize.height);
			break;
	}
	
    // Render
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, displaySize.width, displaySize.height), iref);
	
#else
    CGContextTranslateCTM(context, 0, winSize.height);
	CGContextScaleCTM(context, 1, -1);
	
    // Render
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, winSize.width, winSize.height), iref);
#endif
	
    // Create image
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	
	// Dealloc
	CGDataProviderRelease(provider);
	CGImageRelease(iref);
	CGColorSpaceRelease(colorSpaceRef);
	CGContextRelease(context);
	free(buffer);
	free(pixels);
	
	return imageRef;
}


CGImageRef CHGetScreenShotImageForBlur()
{
    CCDirector *director = [CCDirector sharedDirector];
	CGSize displaySize	= [director displaySizeInPixels];
	CGSize winSize	= [director winSizeInPixels];
	CGSize outSize = CGSizeMake(floorf(winSize.width / 2), floorf(winSize.height / 2));
	
	// Create buffer for pixels
	GLuint bufferLength = displaySize.width * displaySize.height * 4;
	GLubyte* buffer = (GLubyte*)malloc(bufferLength);
	
	// Read Pixels from OpenGL
	glReadPixels(0, 0, displaySize.width, displaySize.height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
	
	// Make data provider with data.
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer, bufferLength, NULL);
	
	// Configure image
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGImageRef iref = CGImageCreate(displaySize.width, displaySize.height, 
									8, 32, 
									displaySize.width * 4, 
									colorSpaceRef, kCGBitmapByteOrderDefault, 
									provider, NULL, NO, kCGRenderingIntentDefault);
	
    // Create buffer for output image
	uint32_t* pixels = (uint32_t*)malloc(outSize.width * outSize.height * 4);
	CGContextRef context = CGBitmapContextCreate(pixels, outSize.width, outSize.height, 
												 8, outSize.width * 4, 
												 colorSpaceRef, 
												 kCGImageAlphaNoneSkipFirst);
    // Transform
    CGContextTranslateCTM(context, 0, outSize.height);
	CGContextScaleCTM(context, 1, -1);
	
    // Render
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, outSize.width, outSize.height), iref);
	
    // Create image
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	
	// Dealloc
	CGDataProviderRelease(provider);
	CGImageRelease(iref);
	CGColorSpaceRelease(colorSpaceRef);
	CGContextRelease(context);
	free(buffer);
	free(pixels);
	
	return imageRef;	
}
