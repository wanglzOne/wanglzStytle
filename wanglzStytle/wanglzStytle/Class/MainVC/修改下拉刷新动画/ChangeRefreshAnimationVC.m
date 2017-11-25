//
//  ChangeRefreshAnimationVC.m
//  wanglzStytle
//
//  Created by lz on 2017/11/25.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "ChangeRefreshAnimationVC.h"
#import "ChangeCell.h"

@interface ChangeRefreshAnimationVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tab;

@property(nonatomic,strong) NSMutableArray  *normalImages;
@property(nonatomic,strong) NSMutableArray  *refreshImages;
@end

@implementation ChangeRefreshAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"刷新动画";
    
    [self.tab registerNib:[UINib nibWithNibName:NSStringFromClass([ChangeCell class]) bundle:nil] forCellReuseIdentifier:@"ChangeCellID"];
    
    //头部
    MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(respondsToBelowUpdateRefresh)];
    [header setImages:self.refreshImages forState:MJRefreshStateRefreshing];
    [header setImages:self.normalImages forState:MJRefreshStateIdle];
    [header setImages:self.refreshImages forState:MJRefreshStatePulling];
    header.lastUpdatedTimeLabel.hidden = YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    header.stateLabel.hidden = YES;
    self.tab.mj_header = header;
    
   
    //尾部

    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(respondsToUpwardUpdateRefresh)];
    [footer setImages:self.refreshImages forState:MJRefreshStateRefreshing];
    [footer setImages:self.normalImages forState:MJRefreshStateIdle];
    [footer setImages:self.refreshImages forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:15];
    footer.stateLabel.hidden = YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    self.tab.mj_footer =footer;
    // 设置颜色
    footer.stateLabel.textColor = [UIColor grayColor];
    
}

//下拉刷新数据

-(void)respondsToBelowUpdateRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tab.mj_header endRefreshing];
        [self.tab reloadData];
    });
}

//上拉加载更多

-(void)respondsToUpwardUpdateRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tab.mj_footer endRefreshing];
        [self.tab reloadData];
    });
    
}

//正在下拉状态下的图片

- (NSMutableArray *)normalImages
{
    if (!_normalImages) {
        _normalImages = [[NSMutableArray alloc] init];
        UIImage *image = [UIImage imageNamed:@"16"];
        UIImage *newImage = [self imageCompressWithSimple:image scaledToSize:CGSizeMake(50, 15)];
        [self.normalImages addObject:newImage];
    }
    return _normalImages;
}


//正在刷新状态下的图片

- (NSMutableArray *)refreshImages
{
    if (!_refreshImages) {
        _refreshImages = [[NSMutableArray alloc] init];
        //循环添加图片
        for (NSUInteger index = 1; index <= 16; index++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", index]];
            UIImage *newImage = [self imageCompressWithSimple:image scaledToSize:CGSizeMake(50, 15)];
            [self.refreshImages addObject:newImage];
        }
    }
    return _refreshImages;
}

//缩放到指定大小

- (UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChangeCellID" forIndexPath:indexPath];
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
