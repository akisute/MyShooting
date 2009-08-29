//
//  MSTGActionFactory.h
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"


#define ACTION_DURATION 10000.0f

@interface MSTGActionFactory : NSObject {

}

+ (Action *)moveByFrom:(CGPoint)from to:(CGPoint)to inSecond:(ccTime)second;
+ (Action *)moveByFrom:(CGPoint)from to:(CGPoint)to speed:(float)speed;
+ (Action *)moveByFrom:(CGPoint)from to:(CGPoint)to degree:(float)degree speed:(float)speed;
+ (Action *)moveByFrom:(CGPoint)from degree:(float)degree speed:(float)speed;
+ (Action *)moveByFrom:(CGPoint)from acceleration:(UIAcceleration *)acceleration;

@end
