//
//  DebugScene.h
//  EatPrototype
//
//  Created by Michael Ramirez on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface DebugLayer : CCLayerColor {
	CCLabelTTF *label;
	CCLabelTTF *maxJumpTimeLabel;
	CCLabelTTF *minJumpTimeLabel;
	CCLabelTTF *gravityRateLabel;
	CCLabelTTF *jumpRateLabel;
	CCMenuItem *debugButton;
}

-(void)addControl:(CCLabelTTF *) controlLabel withHeight:(int)height;
-(void)addControls;
-(void)addSmallControl:(CCLabelTTF *) controlLabel withHeight:(int)height;


@property (nonatomic, retain) CCLabelTTF *label;
@property (nonatomic, retain) CCLabelTTF *maxJumpTimeLabel;
@property (nonatomic, retain) CCLabelTTF *minJumpTimeLabel;
@property (nonatomic, retain) CCLabelTTF *gravityRateLabel;
@property (nonatomic, retain) CCLabelTTF *jumpRateLabel;



@end