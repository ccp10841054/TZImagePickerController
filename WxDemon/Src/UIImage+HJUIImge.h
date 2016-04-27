//
//  UIImage+HJUIImge.h
//  AINursing
//
//  Created by feng on 16/4/10.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HJUIImge)
// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
