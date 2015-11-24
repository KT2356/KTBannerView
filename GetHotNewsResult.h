//
//  GetHotNewsResult.h
//  ZaiChengdu
//
//  Created by Nick Hu on 15/5/22.
//  Copyright (c) 2015年 DigitalChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetHotNewsResult : NSObject;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, assign) NSTimeInterval times;//服务器返回为ms
@end
