//
//  CHUtilities.h
//  ClumsyChef
//
//  Created by Tong on 24/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// Other utitlies
#import "CCNode+Utilities.h"
#import "CCLayer+Utilities.h"

// Some utilties


// Initialize. Call this right after the app finishes launching

void CHUtilitiesInit();

CGSize CHGetWinSize();
CGFloat CHGetWinHeight();
CGFloat CHGetWinWidth();

CGFloat CHGetHalfWinWidth();
CGFloat CHGetHalfWinHeight();
CGPoint CHGetWinCenterPoint();

// Convert the point in the flipped coordinate to the one cocos2d uses
// e.g. CHGetWinPointTL(10, 20) returns {10, 460}
CGPoint CHGetWinPointTL(CGFloat x, CGFloat y);

CGPoint CHGetWinPointTR(CGFloat x, CGFloat y);

CGPoint CHGetWinPointBR(CGFloat x, CGFloat y);

// Color utilities
						  
static inline ccColor3B ccc3Hex(uint32_t hexValue)
{
	uint8_t r, g, b;
	r = (hexValue & 0xff0000) >> 16;
	g = (hexValue & 0x00ff00) >> 8;
	b = (hexValue & 0x0000ff);
	return ccc3(r, g, b);
}

static inline ccColor4B ccc3To4(ccColor3B c)
{
	return ccc4(c.r, c.g, c.b, 255);
}

static inline ccColor4B ccc4Hex(uint32_t hexValue)
{
	return ccc3To4(ccc3Hex(hexValue));
}

// Number utilities
NSString* CHFormatDecimalNumber(NSNumber *num);

