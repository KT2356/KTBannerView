//
//  HotNews.m
//  ZaiChengdu
//
//  Created by Nick Hu on 15/5/21.
//  Copyright (c) 2015年 DigitalChina. All rights reserved.
//

#import "HotNewModel.h"

@implementation HotNewModel
MJCodingImplementation;
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"imgUrl":@"imgurls",
             @"updateTimeStr":@"updatetime",
             @"updateUserName":@"updateuser",
             @"bannerID":@"id",
             @"linkUrl":@"linkurls",
             @"orderId":@"orderid",
             @"callType":@"calltype",
             @"bannerName":@"bnname",
             @"bannerDesc":@"bndesc",
             @"insertUser":@"insertuser",
             @"insertTime":@"inserttime"};
}


@end


