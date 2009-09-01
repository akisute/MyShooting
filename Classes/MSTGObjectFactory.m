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

@interface MSTGCannon : MSTGObject {
    int fireFrames;
    int fireInterval;
}
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
    
    fireInterval = 60;
    fireFrames = fireInterval - 5;
}

- (void)mainPhase:(ccTime)dt
{
    GameSceneLayer *gameSceneLayer = self.gameSceneLayer;
    MSTGObject *player = gameSceneLayer.player;
    
    // Shoot 3 bullets at player
    if (fireFrames++ > fireInterval)
    {
        fireFrames = 0;
        MSTGObject *bullet1 = [MSTGObjectFactory bullet];
        bullet1.position = self.position;
        Action *action1 = [MSTGActionFactory moveByFrom:bullet1.position
                                                    to:player.position
                                                 speed:100];
        [bullet1 runAction:action1];
        [gameSceneLayer addChild:bullet1];
        
        MSTGObject *bullet2 = [MSTGObjectFactory bullet];
        bullet2.position = self.position;
        Action *action2 = [MSTGActionFactory moveByFrom:bullet2.position
                                                    to:player.position
                                                degree:5
                                                 speed:100];
        [bullet2 runAction:action2];
        [gameSceneLayer addChild:bullet2];
        
        MSTGObject *bullet3 = [MSTGObjectFactory bullet];
        bullet3.position = self.position;
        Action *action3 = [MSTGActionFactory moveByFrom:bullet3.position
                                                    to:player.position
                                                degree:-5
                                                 speed:100];
        [bullet3 runAction:action3];
        [gameSceneLayer addChild:bullet3];
    }
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
    MSTGObject *object = [MSTGCannon spriteWithFile:@"cannon.png"];
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