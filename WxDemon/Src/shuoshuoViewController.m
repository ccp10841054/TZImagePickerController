//
//  shuoshuoViewController.m
//  WxDemon
//
//  Created by feng on 16/4/10.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "shuoshuoViewController.h"
#import "HJInputView.h"
#import "HJTableViewCell.h"
#import "HJPhotoPickerView.h"
#import "TZImagePickerController.h"
#import "HJEditImageViewController.h"
#define IMAGE_SIZE (SCREEN_WIDTH - 60)/4

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 自定义将RGB转换成UIColor
#define HJRGBA(r,g,b,a)  [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

@interface shuoshuoViewController ()<UITextFieldDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>{
    UITableView * tableV; //UITableView

}

@property(nonatomic, strong)    HJInputView *inputVTitle;

/* 文本输入框*/
@property(nonatomic, strong)    HJInputView *inputVContent;

/** 选择图片*/
@property(nonatomic, strong)    HJPhotoPickerView *photoPickerV;
/** 图片编辑起*/
@property(nonatomic, strong)    HJEditImageViewController *editVC;
/** 当前选择的图片*/
@property(nonatomic, strong)    NSMutableArray *imageDataSource;

@end

@implementation shuoshuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
}


- (void)viewConfig{
    
    //不自动调整滚动视图的预留空间
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName,nil]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    tableV.backgroundColor = [UIColor redColor];
    
    // 初始化输入标题视图
    _inputVTitle = [[HJInputView alloc]initWithPlaceString:@"在此请输入文本标题" From:FROM_TITLE_TEXT];

    _inputVTitle.textV.delegate = self;

    
    // 初始化输入视图
    _inputVContent = [[HJInputView alloc]initWithPlaceString:@"在此请输入文本内容"From:FROM_CONTENT_TEXT];
    
    _inputVContent.textV.delegate = self;
    
    // 图片选择视图
    _photoPickerV = [[HJPhotoPickerView alloc]init];
    _photoPickerV.frame = CGRectMake(0,5 +_inputVContent.frame.size.height, SCREEN_WIDTH, IMAGE_SIZE);
    
    _photoPickerV.reloadTableViewBlock = ^{
        [tableV reloadData];
    };
    [self addTargetForImage];
    
    // 初始化图片数组
    _imageDataSource = [NSMutableArray array];
    [_imageDataSource addObject:_photoPickerV.addImage];
    
    // 初始化图片编辑控制器
    self.editVC = [[HJEditImageViewController alloc]init];
    
}
// 为图片添加点击事件
- (void)addTargetForImage{
    for (UIButton * button in _photoPickerV.imageViews) {
        [button addTarget:self action:@selector(addPhotos:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addPhotos:(UIButton *)button{
    
    if ([button.currentBackgroundImage isEqual:_photoPickerV.addImage]) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:10 - _imageDataSource.count delegate:self];
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
            [_imageDataSource removeLastObject];
            [_imageDataSource addObjectsFromArray:photos];
            [_imageDataSource addObject:_photoPickerV.addImage];
            [self.photoPickerV setSelectedImages:_imageDataSource];
            [self addTargetForImage];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        _editVC = [[HJEditImageViewController alloc]init];
        _editVC.currentOffset = (int)button.tag;
        _editVC.reloadBlock = ^(NSMutableArray * images){
            [self.photoPickerV setSelectedImages:images];
            [self addTargetForImage];
        };
        _editVC.images = _imageDataSource;
        [self.navigationController pushViewController:_editVC animated:YES];
    }
}

#pragma mark --------------UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        [_inputVTitle.placeholerLabel removeFromSuperview];
    }else{
        [_inputVContent.textV addSubview:_inputVContent.placeholerLabel];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJTableViewCell";
    HJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell = [[HJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        [cell addSubview:_inputVTitle];
        return cell;
    }
//    else if (indexPath.row == 1){
//        [cell addSubview:_inputVContent];
//        return cell;
//    }
    else
    {
        [cell addSubview:_inputVContent];
        [cell addSubview:_photoPickerV];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = _photoPickerV.frame.size.height + _photoPickerV.frame.origin.y + 10;

    if (indexPath.row == 0){
        return   _inputVTitle.frame.size.height;
    }
//    if (indexPath.row == 1){
//        return   _inputVContent.frame.size.height;
//    }

    else
    {
//        return  _photoPickerV.frame.size.height+10;
        return rowHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

#pragma mark --------------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableV deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_inputVTitle becomeFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_inputVTitle resignFirstResponder];
    [_inputVContent.textV resignFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"title is :%@  content is :%@",_inputVTitle.textV.text,_inputVContent.textV.text);
    for (int i = 0; i<_imageDataSource.count; i++) {
         NSData *imageData = UIImageJPEGRepresentation(_imageDataSource[i], 1.0);
        NSLog(@"number is %lu;imagedata is :%@",(unsigned long)_imageDataSource.count,imageData);

    }
}

@end
