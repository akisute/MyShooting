//
//  MainScene.m
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright Masashi Ono 2009. All rights reserved.
//

#import "MainScene.h"
#import "GameScene.h"


@implementation MainScene

- (id)init
{
	if(self = [super init])
	{
		[self addChild:[MainLayer node] z:1];
	}
	return self;
}

@end



@implementation MainLayer

- (id)init
{
	if(self = [super init])
	{
		[MenuItemFont setFontSize:20];
		[MenuItemFont setFontName:@"Helvetica"];
		MenuItem *start = [MenuItemFont itemFromString:@"Start Game" 
												target:self selector:@selector(startGame:)];
		MenuItem *help = [MenuItemFont itemFromString:@"Help" 
                                               target:self selector:@selector(help:)];
		Menu *menu = [Menu menuWithItems:start, help, nil];
		[menu alignItemsVertically];
		[self addChild:menu];
	}
	return self;
}

- (void)startGame:(id)sender
{
    GameScene *scene = [GameScene node];
    TransitionScene *transition = [FadeTransition transitionWithDuration:0.6 scene:scene withColor:ccWHITE];
    [[Director sharedDirector] replaceScene:transition];
}

-(void) help:(id)sender
{
}

@end
