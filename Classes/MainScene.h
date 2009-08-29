//
//  MainScene.h
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright Masashi Ono 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"


@interface MainScene : Scene {
}
@end

@interface MainLayer : Layer {
}

- (void)startGame:(id)sender;
- (void)help:(id)sender;

@end
