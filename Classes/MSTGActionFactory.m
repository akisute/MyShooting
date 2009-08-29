//
//  MSTGActionFactory.m
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "MSTGActionFactory.h"


@implementation MSTGActionFactory

+ (Action *)moveByFrom:(CGPoint)from to:(CGPoint)to inSecond:(ccTime)second
{
    CGPoint targetPosition = ccp((to.x-from.x)*(ACTION_DURATION/second), (to.y-from.y)*(ACTION_DURATION/second));
    Action *action = [MoveBy actionWithDuration:ACTION_DURATION
                                       position:targetPosition];
    return action;
}

+ (Action *)moveByFrom:(CGPoint)from to:(CGPoint)to speed:(float)speed
{
    float dx = speed * (to.x - from.x) * ACTION_DURATION;
    float dy = speed * (to.y - from.y) * ACTION_DURATION;
    CGPoint targetPosition = ccp(dx, dy);
    Action *action = [MoveBy actionWithDuration:ACTION_DURATION
                                       position:targetPosition];
    return action;
}

+ (Action *)moveByFrom:(CGPoint)from to:(CGPoint)to degree:(float)degree speed:(float)speed
{
    float degreeTo = ccpToAngle(ccp(to.x - from.x, to.y - from.y));
    return [MSTGActionFactory moveByFrom:from
                                  degree:degreeTo + degree
                                   speed:speed];
}

+ (Action *)moveByFrom:(CGPoint)from degree:(float)degree speed:(float)speed
{
    float dx = speed * cosf(CC_DEGREES_TO_RADIANS(degree)) * ACTION_DURATION;
    float dy = speed * sinf(CC_DEGREES_TO_RADIANS(degree)) * ACTION_DURATION;
    CGPoint targetPosition = ccp(dx, dy);
    Action *action = [MoveBy actionWithDuration:ACTION_DURATION
                                       position:targetPosition];
    return action;
}

+ (Action *)moveByFrom:(CGPoint)from acceleration:(UIAcceleration *)acceleration
{
    CGPoint targetPosition = ccp(from.x, from.y);
    if (acceleration.x > 0.2)
    {
        targetPosition.x += 100 * ACTION_DURATION;
    }
    else if(acceleration.x < -0.2)
    {
        targetPosition.x -= 100 * ACTION_DURATION;
    }
    
    if (acceleration.y > 0.15)
    {
        targetPosition.y += 100 * ACTION_DURATION;
    }
    else if(acceleration.y < -0.15)
    {
        targetPosition.y -= 100 * ACTION_DURATION;
    }
    
    Action *action = [MoveBy actionWithDuration:ACTION_DURATION
                                       position:targetPosition];
    return action;
}

@end
