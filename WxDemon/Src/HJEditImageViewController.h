//
//  HJEditImageViewController.h
//  AINursing
//
//  Created by feng on 16/4/10.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJEditImageViewController : UIViewController
/** 图片*/
@property(nonatomic,strong)NSMutableArray *images;
/** 当前位置*/
@property(nonatomic,assign)int currentOffset;
/** 部分刷新*/
@property(nonatomic,copy)void(^reloadBlock)(NSMutableArray *);

@end
