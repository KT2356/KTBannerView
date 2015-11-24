//
//  HotNews.h
//  ZaiChengdu
//
//  Created by Nick Hu on 15/5/21.
//  Copyright (c) 2015年 DigitalChina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseModel.h"

@interface HotNewModel : NSObject

@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *updateTimeStr;
@property (nonatomic, strong) NSString *updateUserName;
@property (nonatomic, assign) NSInteger bannerID;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, assign) NSInteger orderId;
@property (nonatomic, assign) NSInteger calltype;
@property (nonatomic, strong) NSString *bannerName;
@property (nonatomic, strong) NSString *bannerDesc;
@property (nonatomic, strong) NSString *insertUser;
@property (nonatomic, strong) NSString *insertTime;
@end

