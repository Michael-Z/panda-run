//
//  OverView.m
//  panda-run
//
//  Created by Qi He on 12-8-4.
//  Copyright (c) 2012年 Heyook. All rights reserved.
//

#import "OverView.h"
#import "Constants.h"

@implementation OverView

@synthesize tryAgainButtonTarget, tryAgainButtonSelector, menuButtonSelector, menuButtonTarget;


- (id) init {
  
  if((self = [super init]))
    
  {
    self.isTouchEnabled = YES;
    
		viewSprite = [CCSprite spriteWithFile:IMAGE_OVER];
		[self addChild:viewSprite z:-1];
    
		CGSize size = viewSprite.contentSize;
    self.anchorPoint = ccp(0,0);
    
    tryAgainButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:IMAGE_BUTTON_TRY_AGAIN] selectedSprite:[CCSprite spriteWithSpriteFrameName:IMAGE_BUTTON_TRY_AGAIN_PRESSED] target:self selector:@selector(tryAgainButtonClicked:)];
    
    menuButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:IMAGE_BUTTON_MENU] selectedSprite:[CCSprite spriteWithSpriteFrameName:IMAGE_BUTTON_MENU_PRESSED] target:self selector:@selector(menuButtonClicked:)];
    
    int heightOffset = size.height/3;
    int widthOffset  = size.width/4;
    int buttonOffset = tryAgainButton.rect.size.height ;
    
    CCMenu *alertMenu = [CCMenu menuWithItems:tryAgainButton, nil];
		alertMenu.anchorPoint = ccp(.5,0);
    //		[alertMenu alignItemsHorizontallyWithPadding:10];
		alertMenu.position = ccp(widthOffset, heightOffset - 3*buttonOffset/4);
		[viewSprite addChild:alertMenu];
    
    alertMenu = [CCMenu menuWithItems:menuButton, nil];
		alertMenu.anchorPoint = ccp(.5,0);
    //		[alertMenu alignItemsHorizontallyWithPadding:10];
		alertMenu.position = ccp(3*widthOffset, heightOffset - 3*buttonOffset/4);
		[viewSprite addChild:alertMenu];
    
		viewSprite.scale = .6;
		viewSprite.opacity = 150;
    
		id fadeIn = [CCFadeIn actionWithDuration:0.1];
		id scale1 = [CCSpawn actions:fadeIn, [CCScaleTo actionWithDuration:0.15 scale:1.1], nil];
		id scale2 = [CCScaleTo actionWithDuration:0.1 scale:0.9];
		id scale3 = [CCScaleTo actionWithDuration:0.05 scale:1.0];
		id pulse = [CCSequence actions:scale1, scale2, scale3, nil];
    
		[viewSprite runAction:pulse];
  }
  
  return self;
}

-(void) tryAgainButtonClicked:(id) sender
{
  [self removeFromParentAndCleanup:YES];
  
  NSMethodSignature * sig = nil;
  
  if( tryAgainButtonTarget && tryAgainButtonSelector ) {
    sig = [tryAgainButtonTarget methodSignatureForSelector:tryAgainButtonSelector];
    
    NSInvocation *invocation = nil;
    invocation = [NSInvocation invocationWithMethodSignature:sig];
    [invocation setTarget:tryAgainButtonTarget];
    [invocation setSelector:tryAgainButtonSelector];
#if NS_BLOCKS_AVAILABLE
    if ([sig numberOfArguments] == 3)
#endif
			[invocation setArgument:&self atIndex:2];
    
    [invocation invoke];
  }
}

-(void) menuButtonClicked:(id) sender
{
  [self removeFromParentAndCleanup:YES];
  
  NSMethodSignature * sig = nil;
  
  if( menuButtonTarget && menuButtonSelector ) {
    sig = [menuButtonTarget methodSignatureForSelector:menuButtonSelector];
    
    NSInvocation *invocation = nil;
    invocation = [NSInvocation invocationWithMethodSignature:sig];
    [invocation setTarget:menuButtonTarget];
    [invocation setSelector:menuButtonSelector];
#if NS_BLOCKS_AVAILABLE
    if ([sig numberOfArguments] == 3)
#endif
			[invocation setArgument:&self atIndex:2];
    
    [invocation invoke];
  }
}



@end