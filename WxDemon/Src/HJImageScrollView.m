//
//  HJImageScrollView.m
//  AINursing
//
//  Created by feng on 16/4/10.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "HJImageScrollView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@implementation HJImageScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH + 20, SCREEN_HEIGHT - 64);
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = YES;
    self.backgroundColor = [UIColor blackColor];
}
@end
