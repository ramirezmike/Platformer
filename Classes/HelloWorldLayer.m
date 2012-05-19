//
//  HelloWorldLayer.m
//  iOSPlatformer
//
//  Created by Michael Ramirez on 5/18/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCMenuItemHoldable.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)buttonTapped:(id)sender
{

}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(255,255,255,255)])) {
		CGSize screenSize = [[CCDirector sharedDirector] winSize];	
		player = [CCSprite spriteWithFile:@"player.png"];
		player.position = ccp(screenSize.width/2,screenSize.height/4);
		
		playerAcceleration = 0.046875;
		playerFriction = 0.046875;
		playerDeceleration = 0.5;
		playerMaxSpeed = 6;
		playerSpeed = 0;
		
		leftButton = [CCMenuItemSpriteHoldable
		itemFromNormalSprite:[CCSprite spriteWithFile:@"Icon-Small.png"] selectedSprite:
			[CCSprite spriteWithFile:@"Icon-Small-50.png"]target:self selector:@selector(buttonTapped:)];
		rightButton = [CCMenuItemSpriteHoldable
		itemFromNormalSprite:[CCSprite spriteWithFile:@"Icon-Small.png"] selectedSprite:
			[CCSprite spriteWithFile:@"Icon-Small-50.png"]target:self selector:@selector(buttonTapped:)];
		
		leftButton.position = ccp(screenSize.width/2 - 40,40);
		rightButton.position = ccp(screenSize.width/2 + 40,40);
		
		CCMenu *debugMenu = [CCMenu menuWithItems:leftButton,rightButton, nil];
		debugMenu.position = CGPointZero;
		
		[self addChild:debugMenu];
		[self addChild:player];
		
		[self schedule:@selector(nextFrame:)];

	}
	return self;
}

-(void)nextFrame:(ccTime)dt
{
		if (!leftButton.buttonHeld && abs(playerSpeed) > 0 && !rightButton.buttonHeld) 
		{
			if (playerSpeed < 0) 
			{
				playerSpeed = playerSpeed + playerFriction;
			}

			if (playerSpeed > 0) 
			{
				playerSpeed = playerSpeed - playerFriction;
			}			
			
			if (abs(playerSpeed) <= 0) 
			{
				playerSpeed = 0;
			}
			player.position = ccp(player.position.x + playerSpeed,player.position.y);
		}
		
		if (leftButton.buttonHeld) 
		{
			if (playerSpeed <= 0) 
			{
				playerSpeed = playerSpeed - playerAcceleration;
			}
			
			if (playerSpeed > 0) 
			{
				playerSpeed = playerSpeed - playerDeceleration;
			}
			
			if (abs(playerSpeed) > playerMaxSpeed) 
			{
				playerSpeed = -playerMaxSpeed;
			}
			
			player.position = ccp( player.position.x + playerSpeed, player.position.y );
		}
		
		if (rightButton.buttonHeld) 
		{
			if (playerSpeed >= 0) 
			{
				playerSpeed = playerSpeed + playerAcceleration;
			}
			
			if (playerSpeed < 0) 
			{
				playerSpeed = playerSpeed + playerDeceleration;
			}
			
			if (abs(playerSpeed) > playerMaxSpeed) 
			{
				playerSpeed = playerMaxSpeed;
			}
			
			player.position = ccp(player.position.x + playerSpeed, player.position.y );
		}
		
		if (player.position.x < -10) 
		{
			player.position = ccp( 480+10, player.position.y );
		}
		if (player.position.x > 480+10) 
		{
			player.position = ccp(-10,player.position.y);
		}
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	// don't forget to call "super dealloc"
	[player release];
	[leftButton release];
	[rightButton release];
	[super dealloc];
}
@end