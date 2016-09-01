//
//  PlayViewController.h
//  SKSPlayer
//
//  Created by KeSen on 9/1/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveItem.h"

@interface PlayerViewController : UIViewController

- (instancetype)initWithLiveItem:(LiveItem *)item;

@end
