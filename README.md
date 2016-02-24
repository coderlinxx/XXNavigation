# XXNavigation
UINavigationBar的颜色随着ScrollView的滑动而产生渐变以及 Push 之后的返回动作完善.

实现方式比较简单,并没有用 runtime 相关的API,只需要在scrollViewDidScroll:方法内根据透明度开启图形上下文绘制图像.

####效果图:

![](https://github.com/coderlinxx/XXNavigation/blob/master/Demo.gif)

####使用方法:

关键步骤:

```Objective-C
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.navAlpha = MIN(0.99 , self.tableView.contentOffset.y / 100);
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[BlackNavigationColor colorWithAlphaComponent:self.navAlpha]] forBarMetrics:UIBarMetricsDefault];
}
```
需要注意的细节:

```Objective-C
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
```
可以将关键语句抽出写一个基类控制器,然后继承即可.
还有不明白的详见 Demo, 里面写的很详细.
