//
//  responseObject.h
//  ZaiChengdu
//
//  Created by Nick Hu on 15/5/15.
//  Copyright (c) 2015年 DigitalChina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface BaseModel : NSObject
@property (nonatomic, copy) NSString *rtnCode;
@property (nonatomic, copy) NSString *rtnMsg;
@end


@interface ResponseModel : NSObject
@property (nonatomic, strong) BaseModel *head;
@property (nonatomic, strong) NSDictionary *body;
@end
