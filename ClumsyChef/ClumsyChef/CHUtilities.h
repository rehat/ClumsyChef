//
//  CHUtilities.h
//  ClumsyChef
//
//  Created by Tong on 24/10/11.
//  Copyright (c) 2011 Think Bulbs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


// Some utilties

static inline ccColor3B cc3Hex(uint32_t hexValue)
{
	uint8_t r, g, b;
	r = (hexValue & 0xff0000) >> 16;
	g = (hexValue & 0x00ff00) >> 8;
	b = (hexValue & 0x0000ff);
	return ccc3(r, g, b);
}

static inline ccColor4B cc3To4(ccColor3B c)
{
	return ccc4(c.r, c.g, c.b, 255);
}

static inline ccColor4B cc4Hex(uint32_t hexValue)
{
	return cc3To4(cc3Hex(hexValue));
}