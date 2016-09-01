//
//  LiveItem.m
//  SKSPlayer
//
//  Created by KeSen on 9/1/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "LiveItem.h"
#import "MJExtension/MJExtension.h"

@implementation LiveItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{  @"shareAddr" : @"share_addr"
             , @"streamAddr" : @"stream_addr"
              };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"creator": [Creator class] };
}

@end

@implementation Creator

@end