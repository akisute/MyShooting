//
//  MSTGObjectFactory.m
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "MSTGActionFactory.h"
#import "MSTGObjectFactory.h"
#import "MSTGObject.h"
#import "GameScene.h"

#pragma mark -
#pragma mark MSTGCannon

@interface MSTGCannon : MSTGObject
@end
@implementation MSTGCannon

- (void)initMSTGObject
{
    [super initMSTGObject];
    
    // Initialize properties
    self.hitBoxSize = CGSizeMake(16, 16);
    self.maxLife = 3;
    self.life = self.maxLife;
    self.damage = 1;
    self.owner = kMSTGObjectOwnerEnemy;
    
    CCLOG(@"life = %d", self.life);
}

- (void)mainPhase:(ccTime)dt
{
    GameSceneLayer *gameSceneLayer = self.gameSceneLayer;
    MSTGObject *player = gameSceneLayer.player;
    
    // Shoot bullets at player
    MSTGObject *bullet = [MSTGObjectFactory bullet];
    bullet.position = self.position;
    Action *action = [MSTGActionFactory moveByFrom:bullet.position
                                                to:player.position
                                             speed:150];
    [MSTGActionFactory moveByFrom:bullet.position
                               to:player.position
                           degree:5
                            speed:150];
    [bullet runAction:action];
    [gameSceneLayer addChild:bullet];
    
    CCLOG(@"life = %d", self.life);
}

@end

#pragma mark -
#pragma mark MSTGObjectFactory

@implementation MSTGObjectFactory

+ (MSTGObject *)ship
{
    MSTGObject *object = [MSTGObject spriteWithFile:@"ship.png"];
    object.hitBoxSize = CGSizeMake(16, 16);
    object.maxLife = 1;
    object.life = object.maxLife;
    object.damage = 10;
    object.owner = kMSTGObjectOwnerPlayer;
    return object;
}

+ (MSTGObject *)cannon
{
    MSTGObject *object = [MSTGObject spriteWithFile:@"cannon.png"];
    return object;
}

+ (MSTGObject *)bullet
{
    MSTGObject *object = [MSTGObject spriteWithFile:@"bullet.png"];
    object.hitBoxSize = CGSizeMake(8, 8);
    object.maxLife = 1;
    object.life = object.maxLife;
    object.damage = 1;
    object.owner = kMSTGObjectOwnerEnemy;
    return object;
}

+ (MSTGObject *)shot
{
    MSTGObject *object = [MSTGObject spriteWithFile:@"shot.png"];
    object.hitBoxSize = CGSizeMake(8, 8);
    object.maxLife = 1;
    object.life = object.maxLife;
    object.damage = 2;
    object.owner = kMSTGObjectOwnerPlayer;
    return object;
}

@end