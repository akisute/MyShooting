//
//  MSTGObjectFactory.h
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@class MSTGObject;

@interface MSTGObjectFactory : NSObject {

}

+ (MSTGObject *)ship;
+ (MSTGObject *)cannon;
+ (MSTGObject *)bullet;
+ (MSTGObject *)shot;

@end
