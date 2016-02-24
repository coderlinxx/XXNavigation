//
//  ViewController.m
//  XXNavigation
//
//  Created by 林祥兴 on 16/2/24.
//  Copyright © 2016年 pogo.inxx. All rights reserved.
//

#import "ViewController.h"
#import "NormalController.h"
#import "TableViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)CGFloat navAlpha;
@end

#define SCREEN_Width ([[UIScreen mainScreen] bounds].size.width)
#define BlackNavigationColor [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1]

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // ShadowImage
    [self.navigationController.navigationBar setShadowImage:[self imageWithBgColor:[BlackNavigationColor colorWithAlphaComponent:0]]];
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"inxx";
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    _tableView.tableHeaderView = [self addHeaderView];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
}

-(UIView *)addHeaderView{
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 200)];
    [header setImage:[UIImage imageNamed:@"header"]];
    header.contentMode = UIViewContentModeScaleAspectFill;
    header.clipsToBounds = YES;
    return header;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"ViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    if (indexPath.row % 2 == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"XXNormalController : %zd",indexPath.row];
    }else{
        cell.textLabel.text =  [NSString stringWithFormat:@"XXTableViewController : %zd",indexPath.row];;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc;
    if (indexPath.row % 2 == 0) {
         vc = [[NormalController alloc] init];
    }else{
        vc = [[TableViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

//如果要监听滚动而使导航栏颜色渐变，那么可以在scrollView的代理方法中添加这样的代码
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.navAlpha = MIN(0.99 , self.tableView.contentOffset.y / 100);
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[BlackNavigationColor colorWithAlphaComponent:self.navAlpha]] forBarMetrics:UIBarMetricsDefault];
}

//这边用的imageWithBgColor方法
-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
