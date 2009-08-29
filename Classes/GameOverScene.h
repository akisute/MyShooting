//
//  GameOverScene.h
//  MyShooting
//
//  Created by Masashi Ono on 09/08/26.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"


@interface GameOverScene : Scene {
}

@end

#pragma mark -

@interface GameOverSceneLayer : Layer {
}

- (void)backToTitle:(id)sender;

@end
