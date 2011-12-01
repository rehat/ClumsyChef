//
//  CHMenuButton.m
//  ClumsyChef
//
//  Created by Tong on 30/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHMenuButton.h"
#import "SimpleAudioEngine.h"

@implementation CHMenuButton
{
	NSString *_soundFilename;
	id		  _target;
	SEL		  _selector;
}


#pragma mark -
#pragma mark Constructor and destructor

- (id)initWithNormalImage:(NSString *)value 
			selectedImage:(NSString *)value2 
			disabledImage:(NSString *)value3 
					sound:(NSString *)filename 
				   target:(id)r 
				 selector:(SEL)s
{
	if (self = [super initFromNormalImage:value 
							selectedImage:value2 
							disabledImage:value3 
								   target:self 
								 selector:@selector(buttonPressed:)])
	{
		_soundFilename = [filename retain];
		_target = r;
		_selector = s;
	}
	return self;
}

- (void)dealloc
{
	[_soundFilename release];
	[super dealloc];
}

+ (id)itemFromImageName:(NSString *)imageName
				  sound:(NSString *)soundName 
				 target:(id)r 
			   selector:(SEL)s
{
	NSString *normal = [imageName stringByAppendingString:@".png"];
	NSString *high = [imageName stringByAppendingString:@"-high.png"];
	return [CHMenuButton itemFromNormalImage:normal selectedImage:high disabledImage:nil sound:soundName 
									  target:r selector:s];
}

+ (id)itemFromNormalImage:(NSString *)value 
			selectedImage:(NSString *)value2 
					sound:(NSString *)filename 
				   target:(id)r 
				 selector:(SEL)s
{
	return [CHMenuButton itemFromNormalImage:value selectedImage:value2 disabledImage:nil sound:filename 
									  target:r selector:s];
}

+ (id)itemFromNormalImage:(NSString *)value 
			selectedImage:(NSString *)value2 
			disabledImage:(NSString *)value3 
					sound:(NSString *)filename 
				   target:(id)r 
				 selector:(SEL)s
{
	return [[[CHMenuButton alloc] initWithNormalImage:value selectedImage:value2 disabledImage:value3 
												sound:filename target:r selector:s] autorelease];
}

#pragma mark - 
#pragma mark UIEvents

- (void)buttonPressed:(id)sender
{
	if (_soundFilename != nil)
	{
		[[SimpleAudioEngine sharedEngine] playEffect:_soundFilename];
	}
	if (_target != nil && _selector != NULL)
	{
		[_target performSelector:_selector withObject:sender];
	}
}

@end
