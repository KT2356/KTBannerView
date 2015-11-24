//
//  KTBannerView.h
//  scrollviewDemo
//
//  Created by KT on 15/11/23.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotNewModel.h"

@protocol KTBannerViewDelegate<NSObject>
- (void)scrollviewDidTapped:(HotNewModel *)hotNewsModel;
@end

@interface KTBannerView : UIView

@property (weak, nonatomic) id <KTBannerViewDelegate> delegate;
- (void)bindData:(NSArray *)dataList;
- (void)bindPlaceHoldImg:(UIImage *)placeHoldImg;
@end
