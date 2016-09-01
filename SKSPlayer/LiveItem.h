//
//  LiveItem.h
//  SKSPlayer
//
//  Created by KeSen on 9/1/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Creator;

@interface LiveItem : NSObject

@property (nonatomic, strong) Creator *creator;
@property (nonatomic, copy) NSString *shareAddr;
@property (nonatomic, copy) NSString *streamAddr;

@end


@interface Creator : NSObject

@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *portrait;

@end