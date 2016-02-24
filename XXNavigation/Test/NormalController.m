//
//  NormalController.m
//  XXEffectNavigition
//
//  Created by 林祥兴 on 16/2/23.
//  Copyright © 2016年 pogo.inxx. All rights reserved.
//

#import "NormalController.h"

@interface NormalController ()

@end

@implementation NormalController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(100, 64, 100, 100);
//    view.frame = self.view.bounds;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
