//
//  ViewController.m
//  scrollviewDemo
//
//  Created by KT on 15/11/23.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "HotNewModel.h"
#import "KTBannerView.h"
#import "DCHTTPRequest.h"
#import "GetHotNewsResult.h"

@interface ViewController ()<KTBannerViewDelegate>
@property (nonatomic, strong) KTBannerView *bannerView;
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBannerView];
    [self loadMobileNewsData];
}

- (void)loadMobileNewsData {
    DCHTTPRequest *request = [[DCHTTPRequest alloc] initWithLoadingType:LoadingTypeNone];
    [request post:@"http://www.zaichengdu.com/cd_portal/service/CW1006"//ApiGetMobileNews
       parameters:@{@"getConfForMgr":@"YES"}
          success:^(AFHTTPRequestOperation *operation, ResponseModel *data, DCRequestError *error) {
              GetHotNewsResult *result = [GetHotNewsResult objectWithKeyValues:data.body];
              //_dataList = [result.dataList arrayByAddingObjectsFromArray:result.dataList] ;
              _dataList = result.dataList;
              [_bannerView bindData:_dataList];
          }
          failure:^(AFHTTPRequestOperation *operation, ResponseModel *data, DCRequestError *error) {
              
          }];
}



/*-------*/
- (void)KTBannerViewDidTapped:(HotNewModel *)hotNewsModel {
    NSLog(@"%@",hotNewsModel.bannerName);
}

- (void)setupBannerView {
    if (!_bannerView) {
        _bannerView = [[KTBannerView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 140)];
        _bannerView.delegate = self;
        [self.view addSubview:_bannerView];
        [_bannerView bindPlaceHoldImg:[UIImage imageNamed:@"placehold"]];
        [_bannerView bindData:_dataList];
    }
}
/*-------*/



@end
