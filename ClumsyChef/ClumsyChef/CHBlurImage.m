//
//  CHBlurImage.m
//  ClumsyChef
//
//  Created by Tong on 23/11/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHBlurImage.h"
#import <Accelerate/Accelerate.h>

static CGImageRef createImageFromBuffer(const vImage_Buffer *buffer)
{
	NSData *data = [[NSData alloc] initWithBytesNoCopy:buffer->data 
												length:buffer->rowBytes * buffer->height 
										  freeWhenDone:YES];
	CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
	[data release];
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGImageRef image = CGImageCreate(buffer->width, buffer->height, 
									 8, 32, 
									 buffer->rowBytes, 
									 colorSpace, 
									 kCGImageAlphaNoneSkipFirst, 
									 provider,
									 NULL, YES, kCGRenderingIntentDefault);
	
	CGDataProviderRelease(provider);
	CGColorSpaceRelease(colorSpace);
	
	return image;
}

CGImageRef CHCreateBlurImage(CGImageRef srcImage, NSUInteger radius, NSUInteger repeatCount)
{
	vImage_Buffer src;
	src.width = CGImageGetWidth(srcImage);
	src.height = CGImageGetHeight(srcImage);
	src.rowBytes = CGImageGetBytesPerRow(srcImage);
	
	uint32_t bufSize = src.rowBytes * src.height;
	src.data = malloc(bufSize);
	
	// Copy the data to src.data
	CGDataProviderRef provider = CGImageGetDataProvider(srcImage);
	CFDataRef data = CGDataProviderCopyData(provider);
	CFDataGetBytes(data, CFRangeMake(0, bufSize), src.data);
	CFRelease(data);
	
	vImage_Buffer dest = src;
	dest.data = malloc(bufSize);
	
	uint32_t kSize = 2 * radius + 1;
	
	vImage_Buffer *pSrc = &src;
	vImage_Buffer *pDest = &dest;
	
	void *tempBuffer = malloc(bufSize);
	for (int i=0; i<repeatCount; i++) 
	{
		vImageBoxConvolve_ARGB8888(pSrc, pDest,
								   tempBuffer, 0, 0, 
								   kSize, kSize, NULL, 
								   kvImageLeaveAlphaUnchanged | kvImageEdgeExtend);
		vImage_Buffer *temp = pSrc;
		pSrc = pDest;
		pDest = temp;
	}
	
	if (repeatCount % 2 != 0)
	{
		// pSrc stores the result
		vImage_Buffer *temp = pSrc;
		pSrc = pDest;
		pDest = temp;		
	}
	
	CGImageRef destImage = createImageFromBuffer(pDest);
	free(pSrc->data);
	free(tempBuffer);
	return destImage;
}
