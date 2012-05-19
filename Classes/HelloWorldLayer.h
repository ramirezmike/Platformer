//
//  HelloWorldLayer.h
//  iOSPlatformer
//
//  Created by Michael Ramirez on 5/18/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCMenuItemHoldable.h"


// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
	CCSprite *player;
	
	float playerMaxSpeed;
	float playerAcceleration;
	float playerDeceleration;
	float playerSpeed;
	float playerFriction;
	
	CCMenuItemSpriteHoldable *leftButton;
	CCMenuItemSpriteHoldable *rightButton;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
