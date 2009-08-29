//
//  GameScene.m
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "GameScene.h"
#import "MainScene.h"
#import "GameOverScene.h"
#import "MSTGActionFactory.h"
#import "MSTGObjectFactory.h"
#import "MSTGObject.h"


@implementation GameScene

- (id)init
{
    if(self = [super init])
    {
        // Add background image and layer
        CGSize size = [[Director sharedDirector] winSize];
        Sprite *backgroundImage = [Sprite spriteWithFile:@"background.png"];
        backgroundImage.position = ccp(size.width/2, size.height/2);
        [self addChild:backgroundImage z:0];
        [self addChild:[GameSceneLayer node] z:1];
    }
    return self;
}

@end

#pragma mark -

@implementation GameSceneLayer

- (id)init
{
    if(self = [super init])
    {
        // Enable touch and accelerometer delegates
        self.isTouchEnabled = YES;
        self.isAccelerometerEnabled = YES;
        // Schedule main roop
        [self schedule:@selector(mainRoop:)];
        
        spawnFrames = 0;
        spawnInterval = 50;
        
        CGSize size = [[Director sharedDirector] winSize];
        
        // Place a ship of player with tag
        MSTGObject *ship = [MSTGObjectFactory ship];
        ship.position = ccp(size.width/2, 32);
        self.player = ship;
    }
    return self;
}

#pragma mark Main roop

- (void)mainRoop:(ccTime)dt
{
    CGSize size = [[Director sharedDirector] winSize];
    
    // If player is dead, game over
    if (!self.player)
    {
        [self unschedule:@selector(mainRoop:)];
        GameOverScene *scene = [GameOverScene node];
        TransitionScene *transition = [FadeTransition transitionWithDuration:2.0
                                                                       scene:scene
                                                                   withColor:ccRED];
        [[Director sharedDirector] replaceScene:transition];
        return;
    }
    
    // Create new enemy per some frames
    if (spawnFrames++ > spawnInterval)
    {
        float positionX = (signed)(arc4random() % (int)(size.width - 20)) + 10;
        MSTGObject *cannon = [MSTGObjectFactory cannon];
        cannon.position = ccp(positionX, size.height - 10);
        Action *action = [MSTGActionFactory moveByFrom:cannon.position
                                                degree:-90
                                                 speed:15];
        [cannon runAction:action];
        [self addChild:cannon];
        spawnFrames = 0;
    }
    
    // Fire some bullets
//    MSTGObject *bullet = [MSTGObjectFactory bullet];
//    bullet.position = ccp(size.width/2, size.height - 10);
//    float delta = (signed)(arc4random() % 51) - 25;
//    Action *action = [MSTGActionFactory moveByFrom:bullet.position
//                                            degree:-90+delta
//                                             speed:150.0];
//    [bullet runAction:action];
//    [self addChild:bullet];

}

#pragma mark Properties

- (MSTGObject *)player
{
    // TODO getChildByTag is relativly slow, use alternative way
    return (MSTGObject *)[self getChildByTag:99999];
}
- (void)setPlayer:(MSTGObject *)aPlayer
{
    [self addChild:aPlayer z:0 tag:99999];
}

#pragma mark Event handling
// Using StandardTouchDelegate methods.
// There is also TargetedTouchDelegate which can handle specific single touches easily.

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // TEMPORALLY: Back to main scene
    MainScene *scene = [MainScene node];
    [[Director sharedDirector] replaceScene:scene];
    return kEventHandled;
}

- (BOOL)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    return kEventIgnored;
}

- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    return kEventIgnored;
}

- (BOOL)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    return kEventIgnored;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    // Controll player with acceleration
    MSTGObject *ship = (MSTGObject *)[self getChildByTag:99999];
    Action *action = [MSTGActionFactory moveByFrom:ship.position acceleration:acceleration];
    if (action)
    {
        [ship runAction:action];
    }
    else
    {
        // TODO: just stop movement actions, not graphical actions
        [ship stopAllActions];
    }
}

@end
