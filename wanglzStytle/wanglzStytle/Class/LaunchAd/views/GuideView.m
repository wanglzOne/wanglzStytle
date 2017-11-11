//
//  GuideView.m
//  wanglzStytle
//
//  Created by lz on 2017/11/10.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "GuideView.h"

@interface GuideView ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIPageControl *page;

@property (nonatomic,strong) NSArray *imageArr;

@end



@implementation GuideView

+ (void)show{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"showGuideKey"] integerValue] <= 0) {
        [self showGuide];
        [userDefaults setObject:@(1) forKey:@"showGuideKey"];
    }
}

+ (void)showGuide{
    GuideView *gview = (GuideView *)[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    gview.frame = window.bounds;
    gview.tag = 199999;
    [window addSubview:gview];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.imageArr = [NSArray arrayWithObjects:@"image0.jpg",@"image1.jpg",@"image2.jpg",@"image3.jpg", nil];
    self.page.currentPageIndicatorTintColor = HexAlphaColor(0xfc4f4f, 1);
    self.page.pageIndicatorTintColor = [UIColor whiteColor];
    if (self.imageArr.count == 1) {
        self.page.numberOfPages = 0;
    }else{
        self.page.numberOfPages = self.imageArr.count;
    }
    self.scroll.delegate = self;
    self.scroll.contentSize = CGSizeMake(KScreenWidth*self.imageArr.count, KScreenHeight);
    for (NSInteger i=0; i<self.imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*KScreenWidth, 0, KScreenWidth, KScreenHeight)];
        imageView.image = [UIImage imageNamed:[self.imageArr objectAtIndex:i]];
        [self.scroll addSubview:imageView];
        
        if (i==self.imageArr.count-1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(0, 0, 120, 36);
            [btn setBackgroundColor:HexAlphaColor(0xfc4f4f, 1)];
            btn.center = CGPointMake(imageView.center.x, KScreenHeight-120);
            [btn setTitle:@"立即体验" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(hideGuide) forControlEvents:UIControlEventTouchUpInside];
            [self.scroll addSubview:btn];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.page.currentPage = scrollView.contentOffset.x/KScreenWidth;


    NSLog(@"%ld",(long)self.page.currentPage);
}
- (void)hideGuide{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
