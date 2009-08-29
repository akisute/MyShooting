//
//  GameOverScene.m
//  MyShooting
//
//  Created by Masashi Ono on 09/08/26.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "GameOverScene.h"
#import "MainScene.h"


@implementation GameOverScene

- (id)init
{
    if(self = [super init])
    {
        [self addChild:[GameOverSceneLayer node] z:1];
    }
    return self;
}

@end

#pragma mark -

@implementation GameOverSceneLayer

- (id)init
{
    if(self = [super init])
    {
        [MenuItemFont setFontSize:20];
        [MenuItemFont setFontName:@"Helvetica"];
        MenuItem *gameOver = [MenuItemFont itemFromString:@"Game Over"
                                                   target:self
                                                 selector:@selector(backToTitle:)];
        Menu *menu = [Menu menuWithItems:gameOver, nil];
        [menu alignItemsVerticallyWithPadding:24];
        [self addChild:menu];
    }
    return self;
}

- (void)backToTitle:(id)sender
{
    MainScene *scene = [MainScene node];
    [[Director sharedDirector] replaceScene:scene];
}

@end
