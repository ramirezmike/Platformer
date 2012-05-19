//
//  CCMenuItemHoldable.h
//  iOSPlatformer
//
//  Created by Michael Ramirez on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"


@interface CCMenuItemSpriteHoldable : CCMenuItemSprite {
	bool buttonHeld;

}
@property (readonly, nonatomic) bool buttonHeld;

@end
