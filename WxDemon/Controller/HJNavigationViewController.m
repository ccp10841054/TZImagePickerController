//
//  HJNavigationViewController.m
//  HJPhotoPikerDemo
//
//  Created by 黄靖 on 16/3/26.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJNavigationViewController.h"

@interface HJNavigationViewController ()

@end

@implementation HJNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
