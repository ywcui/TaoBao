//
//  ViewController1.m
//  TB
//
//  Created by City--Online on 15/11/6.
//  Copyright © 2015年 City--Online. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor greenColor];
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"forIndexPath:indexPath];
    cell.backgroundColor=[UIColor yellowColor];
    cell.textLabel.text=@"444";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
    
//    NSLog(@"%f",offset.y);
    if (offset.y<-50) {
        _headRefReshBlock();
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
