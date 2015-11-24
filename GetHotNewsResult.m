//
//  GetHotNewsResult.m
//  ZaiChengdu
//
//  Created by Nick Hu on 15/5/22.
//  Copyright (c) 2015年 DigitalChina. All rights reserved.
//

#import "GetHotNewsResult.h"
#import "HotNewModel.h"
@implementation GetHotNewsResult
MJCodingImplementation;

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"dataList" : @"datalist"};
}

+ (NSDictionary *)objectClassInArray {
    return @{@"dataList" : @"HotNewModel",};
}


- (void)setTimes:(NSTimeInterval)times {
    _times = times/1000;
}
@end
