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
#import "DebugLayer.h"


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

-(void)debugButtonTapped:(id)sender
{
	DebugLayer *debug = [DebugLayer node];
	[debug.maxJumpTimeLabel setString:[NSString stringWithFormat:@"%f",maxJumpTime]];
	[debug.minJumpTimeLabel setString:[NSString stringWithFormat:@"%f",minJumpTime]];
	[debug.gravityRateLabel setString:[NSString stringWithFormat:@"%f",gravityRate]];
	[debug.jumpRateLabel setString:[NSString stringWithFormat:@"%f",jumpRate]];


	[debug addControls];
	[self addChild:debug];
}

-(void)createDebugButton
{
	debugButton = [CCMenuItemImage
		itemFromNormalImage:@"debug.png" selectedImage:@"debugSel.png"
		target:self selector:@selector(debugButtonTapped:)];
	debugButton.position = ccp(300,430);
	CCMenu *debugMenu = [CCMenu menuWithItems:debugButton, nil];
	debugMenu.position = CGPointZero;
	[self addChild:debugMenu];
}

-(void)setMaxJumpTime:(float) time
{
	maxJumpTime = time;
}

-(void)setMinJumpTime:(float) time
{
	minJumpTime = time;
}

-(void)setGravityRate:(float) rate
{
	gravityRate = rate;
}

-(void)setJumpRate:(float)rate
{
	jumpRate = rate;
}

-(void)buttonTapped:(id)sender
{

}

-(void)jumpButtonTapped:(id)sender
{
	//	groundY = player.position.y;

}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(255,255,255,255)])) {
		screenSize = [[CCDirector sharedDirector] winSize];	
		player = [CCSprite spriteWithFile:@"player.png"];
		player.position = ccp(screenSize.width/2,screenSize.height/4);
		
		playerAcceleration = 0.046875;
		playerFriction = 0.046875;
		playerGravity = -0.21875;
		playerDeceleration = 0.5;
		playerJumpVelocity = 6.5;
		playerMaxSpeed = 6;
		playerSpeed = 0;
		playerVerticalSpeed = 0;
		playerPreviousHeight = 0;
		
		
		playerIsJumping = FALSE;
		playerOnGround = TRUE;
		gravityRate = -0.21875;
		jumpRate = 6.5;
		maxJumpTime = 20;
		minJumpTime = 7;
		currentJumpTime = 0;
		
		[self createDebugButton];

		
		
		leftButton = [CCMenuItemSpriteHoldable
		itemFromNormalSprite:[CCSprite spriteWithFile:@"Icon-Small.png"] selectedSprite:
			[CCSprite spriteWithFile:@"Icon-Small-50.png"]target:self selector:@selector(buttonTapped:)];
		rightButton = [CCMenuItemSpriteHoldable
		itemFromNormalSprite:[CCSprite spriteWithFile:@"Icon-Small.png"] selectedSprite:
			[CCSprite spriteWithFile:@"Icon-Small-50.png"]target:self selector:@selector(buttonTapped:)];
		jumpButton = [CCMenuItemSpriteHoldable
		itemFromNormalSprite:[CCSprite spriteWithFile:@"Icon-Small.png"] selectedSprite:
			[CCSprite spriteWithFile:@"Icon-Small-50.png"]target:self selector:@selector(jumpButtonTapped:)];
		
		leftButton.position = ccp(40,40);
		rightButton.position = ccp(80,40);
		jumpButton.position = ccp(320-40,40);

		CCMenu *directionMenu = [CCMenu menuWithItems:leftButton,rightButton, nil];
		directionMenu.position = CGPointZero;
		CCMenu *jumpMenu = [CCMenu menuWithItems:jumpButton, nil];
		jumpMenu.position = CGPointZero;
		
		[self addChild:directionMenu];
		[self addChild:jumpMenu];
		[self addChild:player];
		
		[self schedule:@selector(nextFrame:)];

	}
	return self;
}

-(void)nextFrame:(ccTime)dt
{
		[self playerMovementCheck];
		[self playerFrictionCheck];

		/*
		[self setGround];
		[self playerFallCheck];
		[self playerJumpCheck];
		[self gravityCheck];
		//NSLog(@"VeticalSpeed: %f",playerVerticalSpeed - previousVerticalSpeed);
		*/
		
		[self isPlayerJumping];
		[self playerJumpMovement];
		[self wallBoundriesCheck];
		//player.position = ccp(player.position.x, player.position.y + playerVerticalSpeed);
		NSLog(@"VeticalSpeed: %f", currentJumpTime);


}

-(void)playerJumpMovement
{
	if (playerIsJumping) 
	{
		if (currentJumpTime > minJumpTime) 
		{
			player.position = ccp(player.position.x, player.position.y + jumpRate);
			currentJumpTime--;
		}
		if (currentJumpTime > 0 && currentJumpTime <= minJumpTime) 
		{
			playerVerticalSpeed = playerVerticalSpeed + gravityRate;
			player.position = ccp(player.position.x, player.position.y + playerVerticalSpeed + jumpRate);
			currentJumpTime--;

		}
		if (currentJumpTime == 0)
		{
			playerVerticalSpeed = playerVerticalSpeed + gravityRate;
			player.position = ccp(player.position.x, player.position.y + playerVerticalSpeed);
		}


	}
}

-(void)isPlayerJumping
{
	if (jumpButton.buttonHeld && playerOnGround && !playerIsJumping) 
	{
		playerOnGround = FALSE;
		playerIsJumping = TRUE;
		playerVerticalSpeed = 0;
		NSLog(@"Player is Jumping!");
		currentJumpTime = maxJumpTime;
	}
	if (!jumpButton.buttonHeld && !playerOnGround) 
	{
		currentJumpTime = 0;
	}
	if (!jumpButton.buttonHeld && playerOnGround) 
	{
		playerIsJumping = FALSE;
		NSLog(@"Player is not Jumping!");

	}

}

-(void)setGround
{
	if (playerVerticalSpeed == 0)
	{
		groundY = player.position.y;
	}
}
-(void)playerFallCheck
{
	if (player.position.y < playerPreviousHeight) 
	{
		playerIsFalling = TRUE;
	}
	else 
	{
		playerIsFalling = FALSE;
	}

	playerPreviousHeight = player.position.y;
}

-(void)gravityCheck
{
	if (player.position.y > screenSize.height/4) 
	{
		previousVerticalSpeed = playerVerticalSpeed;
		playerVerticalSpeed = playerVerticalSpeed + playerGravity;
		player.position = ccp(player.position.x,player.position.y + playerVerticalSpeed);
	}
	else 
	{
		playerVerticalSpeed = 0;
	}

}

-(void)playerJumpCheck
{
	if (jumpButton.buttonHeld && !playerIsFalling && player.position.y - groundY < groundY + playerJumpVelocity) 
	{
		NSLog(@"Player Position: %f", player.position.y);
		NSLog(@"Ground Position: %f", groundY);
		NSLog(@"Jump Height: %f", player.position.y - groundY);
		player.position = ccp(player.position.x,player.position.y + playerJumpVelocity);
	}
	if (playerIsFalling) 
	{
		[jumpButton unselected];
		NSLog(@"Player Position: %f", player.position.y);
		NSLog(@"Ground Position: %f", groundY);
		NSLog(@"Jump Height: %f", player.position.y - groundY);
	}
}

-(void)playerFrictionCheck
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
}

-(void)playerMovementCheck
{
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
}

-(void)wallBoundriesCheck
{
	if (player.position.x < -10) 
	{
		player.position = ccp( 480+10, player.position.y );
	}
	
	if (player.position.x > 480+10) 
	{
		player.position = ccp(-10,player.position.y);
	}
	if (player.position.y < screenSize.height/4) 
	{
		player.position = ccp(player.position.x,screenSize.height/4);
		//playerVerticalSpeed = 0;
		playerOnGround = TRUE;
		//currentJumpTime = 0;
	}
	if (player.position.y > screenSize.height - player.contentSize.height/2) 
	{
		player.position = ccp(player.position.x,screenSize.height - player.contentSize.height/2);
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
