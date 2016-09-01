//
//  PlayViewController.m
//  SKSPlayer
//
//  Created by KeSen on 9/1/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "PlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@implementation PlayerViewController
{
    LiveItem *_item;
    IJKFFMoviePlayerController *_IJKPlayerVc;
}

- (instancetype)initWithLiveItem:(LiveItem *)item
{
    PlayerViewController *player = [PlayerViewController new];

    
    _IJKPlayerVc = ({
        IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:item.streamAddr] withOptions:nil];
        playerVc.view.frame = [UIScreen mainScreen].bounds;
        [self.view addSubview:playerVc.view];
        [playerVc prepareToPlay];
        
        playerVc;
    });
    
    return player;
}

@end
