//
//  ViewController.m
//  UIScrollView无线轮播
//
//  Created by myApplePro01 on 16/4/28.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>



@property (nonatomic, strong) UIScrollView*       scrollView;
@property (nonatomic, strong) NSArray        *imageArray;


@end

@implementation ViewController

- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[@"001.jpg",@"002.jpg",@"003.jpg"];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScrollView];
}

#pragma mark -private Methods-
- (void)initScrollView
{
    if (_scrollView) {
        return;
    }
    _scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        scrollView.bounces = YES;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        if(self.imageArray.count < 2){
            scrollView.scrollEnabled = NO;
        }
        [self.view addSubview:scrollView];
        scrollView;
    });
    
        for (NSInteger i = 0; i < _imageArray.count; i++) {
            UIImageView *slideImage = [[UIImageView alloc] init];
            slideImage.image = [UIImage imageNamed:_imageArray[i]];
            slideImage.tag = i;
            slideImage.frame = CGRectMake(_scrollView.frame.size.width * i + _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
            [_scrollView addSubview:slideImage];// 首页是第0页,默认从第1页开始的。所以+_scrollView.frame.size.width
    }
    
    // 取数组最后一张图片 放在第0页
    UIImageView *firstSlideImage = [[UIImageView alloc] init];
    firstSlideImage.image = [UIImage imageNamed:_imageArray[_imageArray.count - 1]];
    firstSlideImage.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:firstSlideImage];
    
    
    // 取数组的第一张图片 放在最后1页
    UIImageView *endSlideImage = [[UIImageView alloc] init];
    endSlideImage.image = [UIImage imageNamed:_imageArray[0]];
    endSlideImage.frame = CGRectMake((_imageArray.count + 1) * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:endSlideImage];
    
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * (_imageArray.count + 2), _scrollView.frame.size.height)];
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    //滚到第一页显示区域
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger currentPage = floor((self.scrollView.contentOffset.x - pageWith/ ([_imageArray count]+2)) / pageWith) + 1;
    
    if (currentPage == 0) {

        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * _imageArray.count, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
        
    }else if(currentPage == _imageArray.count + 1){
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width,_scrollView.frame.size.height) animated:NO
         ];
    }else{

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
