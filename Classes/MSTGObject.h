//
//  MSTGObject.h
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@class GameSceneLayer;


typedef enum _kMSTGObjectOwner {
    kMSTGObjectOwnerWorld = 0,
    kMSTGObjectOwnerPlayer = 1,
    kMSTGObjectOwnerEnemy = 2,
} kMSTGObjectOwner;

/** A base class for all in-game objects.
 Each MSTGObject has their own Sprite inside to draw themselves on screen (and for positioning).
 
 MSTGObject features:
 - How the object moves
 - Hit testing
 */
@interface MSTGObject : Sprite {
    /** Size of the hit box of this object. */
    CGSize hitBoxSize;
    kMSTGObjectOwner owner;
    int maxLife;
    int life;
    int damage;
    int invulnerableFrames;
    BOOL isInvulnerable;
}

#pragma mark Init, Dealloc, Memory management

/** Designated initializer of this object. Called after normal initialzer creates this instance.
 This methods is called by framework, so users MUST not call this initializer directly.
 */
- (void)initMSTGObject;

#pragma mark On frame callback and phases

- (BOOL)hitTest:(MSTGObject *)targetObject;
/** Called on every frames. Override this method to define custom behavior for this object.
 The default implementation of this method does nothing.
 @param dt - delta time from previous frame.
 */
- (void)onFrame:(ccTime)dt;

- (void)upkeepPhase:(ccTime)dt;
- (void)mainPhase:(ccTime)dt;
- (MSTGObject *)hitTestPhase:(ccTime)dt;
- (void)cleanupPhase;

#pragma mark Utility methods

/** Tests if this object is hit to the target object.
 @param targetObject - target object.
 @retval YES - this object is hit to the target object.
 @retval NO - both object is not hit.
 */
- (BOOL)hitTest:(MSTGObject *)targetObject;

#pragma mark Properties

/** Hit box of this object. A default hit box is at the center of this object with 0 width/height. */
@property (nonatomic, readonly) CGRect hitBox;
/** Size of hit box. Setting this property will change the returning CCRect of hitBox property. */
@property (nonatomic, assign) CGSize hitBoxSize;
/** Returns game scene layer which contains this object. */
@property (nonatomic, readonly) GameSceneLayer *gameSceneLayer;

@property (nonatomic, assign) kMSTGObjectOwner owner;
@property (nonatomic, assign) int maxLife;
@property (nonatomic, assign) int life;
@property (nonatomic, assign) int damage;
@property (nonatomic, assign) int invulnerableFrames;
@property (nonatomic, assign) BOOL isInvulnerable;
@property (nonatomic, readonly) BOOL isCurrentlyInvulnerable;

@end
