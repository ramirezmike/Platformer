//
//  DebugScene.m
//  EatPrototype
//
//  Created by Michael Ramirez on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DebugLayer.h"
#import "HelloWorldLayer.h"


@implementation DebugLayer
@synthesize label;
@synthesize maxJumpTimeLabel = maxJumpTimeLabel;
@synthesize minJumpTimeLabel = minJumpTimeLabel;
@synthesize gravityRateLabel = gravityRateLabel;
@synthesize jumpRateLabel = jumpRateLabel;

-(void)increaseControl:(id)sender
{
	float controlLabelNumber = [[(id)[sender userData]string]floatValue];
	controlLabelNumber++;
	NSString* controlLabelNumberString = [NSString stringWithFormat:@"%f",controlLabelNumber];
	[(id)[sender userData] setString: controlLabelNumberString];
}

-(void)decreaseControl:(id)sender
{
	float controlLabelNumber = [[(id)[sender userData]string]floatValue];
	controlLabelNumber--;
	NSString* controlLabelNumberString = [NSString stringWithFormat:@"%f",controlLabelNumber];
	[(id)[sender userData] setString: controlLabelNumberString];
}

-(void)increaseSmallControl:(id)sender
{
	float controlLabelNumber = [[(id)[sender userData]string]floatValue];
	controlLabelNumber += 0.1;
	NSString* controlLabelNumberString = [NSString stringWithFormat:@"%f",controlLabelNumber];
	[(id)[sender userData] setString: controlLabelNumberString];
}

-(void)decreaseSmallControl:(id)sender
{
	float controlLabelNumber = [[(id)[sender userData]string]floatValue];
	controlLabelNumber -= 0.1;
	NSString* controlLabelNumberString = [NSString stringWithFormat:@"%f",controlLabelNumber];
	[(id)[sender userData] setString: controlLabelNumberString];
}

-(void)addControl:(CCLabelTTF *) controlLabel withHeight:(int)height
{
	CCMenuItem* plusButton = [CCMenuItemImage
		itemFromNormalImage:@"plus.png" selectedImage:@"plus.png"
		target:self selector:@selector(increaseControl:)];
	plusButton.userData = controlLabel;
	plusButton.position = ccp(170,height);
	
	CCLabelTTF* debugControlLabel = controlLabel;
	debugControlLabel.position = ccp (100, height);
	
	NSLog(@"%s",[controlLabel string]);
	
	CCMenuItem* minusButton = [CCMenuItemImage
		itemFromNormalImage:@"minus.png" selectedImage:@"minus.png"
		target:self selector:@selector(decreaseControl:)];
	minusButton.userData = controlLabel;
	minusButton.position = ccp(20,height-2);
	
	CCMenu *control = [CCMenu menuWithItems:plusButton, minusButton, nil];
	control.position = CGPointZero;
	[self addChild:control];
	[self addChild:debugControlLabel];
}

-(void)addSmallControl:(CCLabelTTF *) controlLabel withHeight:(int)height
{
	CCMenuItem* plusButton = [CCMenuItemImage
		itemFromNormalImage:@"plus.png" selectedImage:@"plus.png"
		target:self selector:@selector(increaseSmallControl:)];
	plusButton.userData = controlLabel;
	plusButton.position = ccp(170,height);
	
	CCLabelTTF* debugControlLabel = controlLabel;
	debugControlLabel.position = ccp (100, height);
	
	NSLog(@"%s",[controlLabel string]);
	
	CCMenuItem* minusButton = [CCMenuItemImage
		itemFromNormalImage:@"minus.png" selectedImage:@"minus.png"
		target:self selector:@selector(decreaseSmallControl:)];
	minusButton.userData = controlLabel;
	minusButton.position = ccp(20,height-2);
	
	CCMenu *control = [CCMenu menuWithItems:plusButton, minusButton, nil];
	control.position = CGPointZero;
	[self addChild:control];
	[self addChild:debugControlLabel];
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

-(void)debugButtonTapped:(id)sender
{
	[(HelloWorldLayer*)self.parent setMaxJumpTime:[[maxJumpTimeLabel string]floatValue]];
	[(HelloWorldLayer*)self.parent setMinJumpTime:[[minJumpTimeLabel string]floatValue]];
	[(HelloWorldLayer*)self.parent setGravityRate:[[gravityRateLabel string]floatValue]];
	[(HelloWorldLayer*)self.parent setJumpRate:[[jumpRateLabel string]floatValue]];



	[self.parent removeChild:self cleanup:TRUE];
}

-(id) init
{
	if ((self=[super initWithColor:ccc4(225,225,225,225)]))
	{
		CGSize winSize = [[CCDirector sharedDirector]winSize];
		self.label = [CCLabelTTF labelWithString:@"DEBUG" fontName:@"Arial" fontSize:32];
		label.color = ccc3(0,0,0);
		
		self.maxJumpTimeLabel = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:18];
		maxJumpTimeLabel.color = ccc3(0,0,0);
		
		self.minJumpTimeLabel = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:18];
		minJumpTimeLabel.color = ccc3(0,0,0);
		
		self.gravityRateLabel = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:18];
		gravityRateLabel.color = ccc3(0,0,0);
		
		self.jumpRateLabel = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:18];
		jumpRateLabel.color = ccc3(0,0,0);
		
		label.opacity = 40;
		label.position = ccp(winSize.width/2, winSize.height/2);
		
		[self addChild:label];
		
		[self createDebugButton];
		
	}
	return self;
}

-(void)addControls
{
	[self addControl:maxJumpTimeLabel withHeight:300];
	[self addControl:minJumpTimeLabel withHeight:270];
	[self addSmallControl:gravityRateLabel withHeight:240];
	[self addSmallControl:jumpRateLabel withHeight:200];

}

-(void)dealloc
{
	[label release];
	label = nil;
	[super dealloc];
}

@end
