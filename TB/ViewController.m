//
//  ViewController.m
//  TB
//
//  Created by City--Online on 15/11/6.
//  Copyright © 2015年 City--Online. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) ViewController1 *vc1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    _scrollView.backgroundColor=[UIColor redColor];
    _scrollView.delegate=self;
    _scrollView.pagingEnabled=YES;
    [self.view addSubview:_scrollView];
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor greenColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    label.text=@"继续拖动,查看更多";
    label.textAlignment=NSTextAlignmentCenter;
    _tableView.tableFooterView=label;
//    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    
    [_scrollView addSubview:_tableView];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    
    
    CGRect bounds = scrollView.bounds;
    
    
    
    CGSize size = scrollView.contentSize;
    
    
    
    UIEdgeInsets inset = scrollView.contentInset;
    
    
    
    CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
    
    
    
    CGFloat maximumOffset = size.height;
    
    
    
    //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。也可以根据这两个值的差来让他做点其他的什么事情
    
    
    //    NSLog(@"%lf",currentOffset-maximumOffset);
    CGFloat offsetY=currentOffset-maximumOffset;
    
    
    if (scrollView==_tableView) {
        
        if (offsetY>60) {
            _tableView.bounces=NO;
            _scrollView.pagingEnabled=YES;
            _scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*2);
            if (_vc1==nil) {
                _vc1=[[ViewController1 alloc]init];
                __weak ViewController *weakSelf=self;
                _vc1.headRefReshBlock=^()
                {
                    [UIView animateWithDuration:1 animations:^{
                       weakSelf.tableView.frame=CGRectMake(0, 0, weakSelf.view.bounds.size.width, weakSelf.view.bounds.size.height);
                        weakSelf.vc1.view.frame=CGRectMake(0, weakSelf.view.bounds.size.height, weakSelf.view.bounds.size.width, weakSelf.view.bounds.size.height);
                    }  completion:^(BOOL finished) {
                        weakSelf.scrollView.contentSize=CGSizeMake(weakSelf.view.bounds.size.width, weakSelf.view.bounds.size.height*2);
                    }];
                };
                [self addChildViewController:_vc1];
                _vc1.view.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
                [_scrollView addSubview:_vc1.view];
                
            }
            [UIView animateWithDuration:1 animations:^{
                _tableView.frame=CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
                _vc1.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            }  completion:^(BOOL finished) {
                _scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
                _tableView.bounces=NO;
            }];
        }
        else
        {
            _vc1.view.frame=CGRectMake(0, self.view.bounds.size.height-offsetY, self.view.bounds.size.width, self.view.bounds.size.height);
        }
    }
    else
    {
//        NSLog(@"%f",offset.y);
        if (offset.y<self.view.bounds.size.height) {
            [UIView animateWithDuration:0.5 animations:^{
                _tableView.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                _vc1.view.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
            }  completion:^(BOOL finished) {
                    _scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
                _tableView.bounces=YES;
            }];
        }
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"forIndexPath:indexPath];
    cell.backgroundColor=[UIColor blueColor];
    cell.textLabel.text=@"2";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
