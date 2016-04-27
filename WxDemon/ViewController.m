//
//  ViewController.m
//  WxDemon
//
//  Created by feng on 16/4/10.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ViewController.h"
#import "shuoshuoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonAction:(id)sender {
    shuoshuoViewController*vc = [[shuoshuoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
