//
//  KTBannerView.m
//  scrollviewDemo
//
//  Created by KT on 15/11/23.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTBannerView.h"
#import "UIImageView+Webcache.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kTimmerTrigger   3

@interface KTBannerView ()<UIScrollViewDelegate>
{
    NSInteger _currentPage;
    NSTimer *_timer;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *bannerLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *bannerPageControl;
@property (weak, nonatomic) IBOutlet UIView *bannerMaskView;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) UIImage *placeHoldImg;
@end

@implementation KTBannerView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"KTBannerView" owner:self options:nil] firstObject];
        [self setFrame:frame];
    }
    return self;
}

- (void)dealloc {
    [_timer invalidate];
     _timer = nil;
}

#pragma mark - public methods
- (void)bindData:(NSArray *)dataList {
    self.dataList     = dataList;
    self.scrollView.scrollEnabled = _dataList.count > 1 ? YES : NO;
    _bannerMaskView.hidden    = _dataList.count > 0 ? NO : YES;
    self.bannerPageControl.currentPage = _currentPage;
    if (_dataList.count > 0) {
        [self setupSubImageView];
    }
}

- (void)bindPlaceHoldImg:(UIImage *)placeHoldImg {
    self.placeHoldImg = placeHoldImg;
}


#pragma mark - private methods

/**
 *  @author KT, 2015-11-24 10:34:23
 *
 *  首尾多加两图实现轮播，图片比数据源多两个，转换index
 *
 *  @param imageIndex 不同位置图片的index
 *
 *  @return 图片对应数据源index
 */
- (int)transferToDataIndex:(int)imageIndex {
    int dataIndex;
    if ( imageIndex == 0) {
        dataIndex = (int)_dataList.count -1;
    } else if ( imageIndex == _dataList.count + 1) {
        dataIndex = 0;
    } else  {
        dataIndex = imageIndex - 1;
    }
    return dataIndex;
}


- (void)setupSubImageView {
    for (id subV in _scrollView.subviews) {
        if ([subV isKindOfClass:[UIImageView class]]) {
            [subV removeFromSuperview];
        }
    }
    
    for (int imageIndex = 0; imageIndex < _dataList.count + 2; imageIndex ++) {
        int dataIndex;
        dataIndex = [self transferToDataIndex:imageIndex];
        
        HotNewModel *model = _dataList[dataIndex];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake( (self.bounds.origin.x + UISCREEN_WIDTH * imageIndex),
                                       self.bounds.origin.y,
                                       UISCREEN_WIDTH,
                                       self.bounds.size.height);
        [_scrollView addSubview:imageView];
        if (model) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.zaichengdu.com/%@",model.imgUrl]] placeholderImage:self.placeHoldImg];
            self.bannerLabel.text = model.bannerName;
        }
    }
    [_scrollView setContentOffset:CGPointMake(UISCREEN_WIDTH, 0)];
    if (_dataList.count > 1) {
        [self timerFire];
    }
}

- (void)timerFire {
    if ([_timer isValid]) {
        return;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:kTimmerTrigger
                                              target:self
                                            selector:@selector(timerAction)
                                            userInfo:nil
                                             repeats:YES];
}

#pragma mark - Action
- (void)timerAction {
    [_scrollView setContentOffset:CGPointMake(UISCREEN_WIDTH * (_currentPage + 2), 0) animated:YES];
    _currentPage ++;
    //最后一张图
    if (_currentPage == _dataList.count) {
        _currentPage = 0;
        //等滑动动画结束后，切换图片
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_scrollView setContentOffset:CGPointMake(UISCREEN_WIDTH , 0) animated:NO];
        });
    }
    _bannerPageControl.currentPage = _currentPage;
    HotNewModel *model = _dataList[_currentPage];
    if (model) {
        _bannerLabel.text = model.bannerName;
    }
}


#pragma mark - delegate trigger
- (void)scrollViewTapped {
    HotNewModel *model = _dataList[_currentPage];
    if (model) {
        [self.delegate scrollviewDidTapped:model];
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x - (_currentPage+1) * UISCREEN_WIDTH > 0) {
        _currentPage ++;
    }
    if (scrollView.contentOffset.x - (_currentPage+1) * UISCREEN_WIDTH < 0) {
        _currentPage --;
    }
    
    if (scrollView.contentOffset.x >= UISCREEN_WIDTH * (_dataList.count + 1) ) {
        _currentPage = 0;
        [scrollView setContentOffset:CGPointMake(UISCREEN_WIDTH, 0)];
    }
    if (scrollView.contentOffset.x <= 0) {
        _currentPage = _dataList.count - 1;
        [scrollView setContentOffset:CGPointMake(UISCREEN_WIDTH*_dataList.count, 0)];
    }
    
    HotNewModel * model = _dataList[_currentPage];
    if (model) {
        _bannerLabel.text = model.bannerName;
    }
    _bannerPageControl.currentPage = _currentPage;
    [self timerFire];
}


#pragma mark - setter/getter
- (UIScrollView *)scrollView {
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped)];
    [_scrollView addGestureRecognizer:tapped];
    
    [_scrollView setContentSize:CGSizeMake(UISCREEN_WIDTH * (_dataList.count + 2),
                                           self.bounds.size.height)];
    _scrollView.delegate = self;
    return _scrollView;
}

- (UIPageControl *)bannerPageControl {
    _bannerPageControl.numberOfPages = _dataList.count;
    _bannerPageControl.hidden = _dataList.count <= 1 ? YES : NO;
    return _bannerPageControl;
}

- (NSArray *)dataList {
    if (!_dataList) {
        _dataList = [[NSArray alloc] init];
    }
    return _dataList;
}

- (UIImage *)placeHoldImg {
    if (!_placeHoldImg) {
        _placeHoldImg = [[UIImage alloc] init];
    }
    return _placeHoldImg;
}

@end
