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
@class DebugLayer;


// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
	CGSize screenSize;
	CCSprite *player;
	CCSprite *platform1;
	CCSprite *platform2;
	
	NSMutableArray* _platforms;
	
	CGRect leftFloorSide;
	CGRect rightFloorSide;
	
	CCMenuItem *debugButton;
	DebugLayer *debug;
	
	BOOL playerIsJumping;
	BOOL playerOnGround;
	float gravityRate;
	float jumpRate;
	float maxJumpTime;
	float minJumpTime;
	float currentJumpTime;
	float playerVerticalSpeed;
	float maxFallRate;
		
	float playerMaxSpeed;
	float playerAcceleration;
	float playerDeceleration;
	float playerSpeed;
	float playerFriction;

		
	CCMenuItemSpriteHoldable *leftButton;
	CCMenuItemSpriteHoldable *rightButton;
	CCMenuItemSpriteHoldable *jumpButton;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void)playerFrictionCheck;
-(void)playerMovementCheck;
-(void)wallBoundriesCheck;

-(void)setPlayerSensors;
-(void)checkIntersections;



-(void)isPlayerJumping;
-(void)playerJumpMovement;
-(void)setMaxJumpTime:(float) time;
-(void)setMinJumpTime:(float) time;
-(void)setGravityRate:(float) rate;
-(void)setJumpRate:(float) rate;


@end
