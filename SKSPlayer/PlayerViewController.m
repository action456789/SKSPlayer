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
}

- (instancetype)initWithLiveItem:(LiveItem *)item
{
    PlayerViewController *player = [PlayerViewController new];
    _item = item;
    
    return player;
}

@end
