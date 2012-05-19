//
//  CCMenuItemHoldable.m
//  iOSPlatformer
//
//  Created by Michael Ramirez on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CCMenuItemHoldable.h"


@implementation CCMenuItemSpriteHoldable
@synthesize buttonHeld;

-(void) selected
{
	[super selected];
	buttonHeld = TRUE;
//	[self setOpacity:64];
}

-(void) unselected
{
	[super unselected];
	buttonHeld = FALSE;
//	[self setOpacity:100];
}

@end
