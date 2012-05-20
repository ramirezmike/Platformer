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
	CGSize screenSize;
	CCSprite *player;
	
	BOOL playerIsFalling;
	
	float playerMaxSpeed;
	float playerAcceleration;
	float playerDeceleration;
	float playerJumpVelocity;
	float playerSpeed;
	float playerVerticalSpeed;
	float previousVerticalSpeed;
	float playerFriction;
	float playerGravity;
	float playerPreviousHeight;
	
	float groundY;
	
	CCMenuItemSpriteHoldable *leftButton;
	CCMenuItemSpriteHoldable *rightButton;
	CCMenuItemSpriteHoldable *jumpButton;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void)playerFrictionCheck;
-(void)playerMovementCheck;
-(void)wallBoundriesCheck;
-(void)gravityCheck;
-(void)playerJumpCheck;
-(void)playerFallCheck;
-(void)setGround;


@end
