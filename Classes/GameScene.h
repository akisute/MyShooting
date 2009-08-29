//
//  GameScene.h
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"


@class MSTGObject;

@interface GameScene : Scene {

}

@end

#pragma mark -

@interface GameSceneLayer : Layer {
    int spawnFrames;
    int spawnInterval;
}

- (void)mainRoop:(ccTime)dt;

@property (nonatomic, assign) MSTGObject *player;

@end
