//
//  MSTGObject.m
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "MSTGObject.h"
#import "GameScene.h"


@implementation MSTGObject

#pragma mark Init, Dealloc, Memory management

- (void)initMSTGObject
{
    // Schedule onFrame function
    [self schedule:@selector(onFrame:)];
    
    // Initialize properties
    self.maxLife = 0;
    self.life = self.maxLife;
    self.damage = 0;
    self.invulnerableFrames = 0;
    self.isInvulnerable = NO;
}

- (id)initWithFile:(NSString *)imageFile
{
    if(self = [super initWithFile:imageFile])
    {
        [self initMSTGObject];
    }
    return self;
}
- (id) initWithCGImage: (CGImageRef) image
{
    if(self = [super initWithCGImage:image])
    {
        [self initMSTGObject];
    }
    return self;
}
- (id) initWithTexture:(Texture2D*) tex
{
    if(self = [super initWithTexture:tex])
    {
        [self initMSTGObject];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark On frame callback and phases

- (void)onFrame:(ccTime)dt
{
    // --------------------------------------------------
    // 1. Upkeep phase
    // --------------------------------------------------
    [self upkeepPhase:dt];
    
    // --------------------------------------------------
    // 2. Main phase
    // --------------------------------------------------
    [self mainPhase:dt];
    
    // --------------------------------------------------
    // 3. HitTest phase
    // --------------------------------------------------
    MSTGObject *hitTarget = [self hitTestPhase:dt];
    
    // --------------------------------------------------
    // 4. Cleanup phase
    //    Invoke cleanup phase for both self and collisioned target
    // --------------------------------------------------
    [self cleanupPhase];
    if (hitTarget)
    {
        [hitTarget cleanupPhase];
    }

}

- (void)upkeepPhase:(ccTime)dt
{
    // Decrease invulnerable frame count
    self.invulnerableFrames = (self.invulnerableFrames > 1) ? self.invulnerableFrames - 1 : 0;
}

- (void)mainPhase:(ccTime)dt
{
    // do nothing, override this method for each objects
}

- (MSTGObject *)hitTestPhase:(ccTime)dt
{
    // HitTest objects
    for (id node in self.parent.children) {
        if ([node isKindOfClass:[MSTGObject class]])
        {
            MSTGObject *target = (MSTGObject *)node;
            
            // Don't hit check if target is currently invulnerable
            // Don't hit check if target is not foe
            if (target.isCurrentlyInvulnerable)
            {
                continue;
            }
            else if (target.owner == kMSTGObjectOwnerWorld || target.owner == self.owner)
            {
                continue;
            }
            
            // If hit, damage both objects
            // And make both objects invulnerable for a short period of time...? (bullets should, but units should not)
            if ([self hitTest:target])
            {
                target.life = target.life - self.damage;
                self.life = self.life - target.damage;
                return target;
            }
        }
    }
    // Didnt't hit any targets, return nil
    return nil;
}

- (void)cleanupPhase
{
    // Kill this object when life goes zero
    // Kill this object when out-of-bound
    CGSize size = [[Director sharedDirector] winSize];
    if (self.life <= 0)
    {
        [self.parent removeChild:self cleanup:YES];
    }
    else if (self.position.x + self.contentSize.width < 0
             || self.position.x - self.contentSize.width > size.width
             || self.position.y + self.contentSize.height < 0
             || self.position.y - self.contentSize.height > size.height)
    {
        [self.parent removeChild:self cleanup:YES];
    }
}

#pragma mark Utility methods

- (BOOL)hitTest:(MSTGObject *)targetObject
{
    return (BOOL)CGRectContainsRect(self.hitBox, targetObject.hitBox);
    //    return (self.hitBox.origin.x < targetObject.hitBox.origin.x + targetObject.hitBox.size.width
    //            && targetObject.hitBox.origin.x < self.hitBox.origin.x + self.hitBox.size.width
    //            && self.hitBox.origin.y < targetObject.hitBox.origin.y + targetObject.hitBox.size.height
    //            && targetObject.hitBox.origin.y < self.hitBox.origin.y + self.hitBox.size.height);
}

#pragma mark Properties

- (CGRect)hitBox
{
    return CGRectMake(self.position.x - hitBoxSize.width/2
                      , self.position.y - hitBoxSize.height/2
                      , hitBoxSize.width
                      , hitBoxSize.height);
}

- (GameSceneLayer *)gameSceneLayer
{
    return (GameSceneLayer *)self.parent;
}

@synthesize hitBoxSize;
@synthesize owner;
@synthesize maxLife;
@synthesize life;
@synthesize damage;
@synthesize invulnerableFrames;
@synthesize isInvulnerable;

- (BOOL)isCurrentlyInvulnerable
{
    return isInvulnerable || (invulnerableFrames > 0);
}

@end
