//
//  HJInputView.m
//  AINursing
//
//  Created by feng on 16/4/10.
//  Copyright© 2016年 feng. All rights reserved.
//

#import "HJInputView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// 自定义将RGB转换成UIColor
#define HJRGBA(r,g,b,a)  [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]



@implementation HJInputView{
    NSString *placeholerStr;
    FROM_TEXT m_from;
}

- (instancetype)initWithPlaceString:(NSString*)str From:(FROM_TEXT)from;
{
    self = [super init];
    if (self) {
        placeholerStr = str;
        m_from = from;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    _textV = [[UITextView alloc]init];
    if (FROM_CONTENT_TEXT == m_from) {
        self.frame = CGRectMake(5, 0, SCREEN_WIDTH - 10, 120);
    }
    if (FROM_TITLE_TEXT == m_from) {
        self.frame = CGRectMake(5, 0, SCREEN_WIDTH - 10, 48);
    }
    _textV.frame = self.frame;
    _textV.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textV];
    
    _placeholerLabel = [[UILabel alloc]init];
    _placeholerLabel.frame = CGRectMake(5, 5, SCREEN_WIDTH, 22);
    _placeholerLabel.text = placeholerStr;
    _placeholerLabel.textColor = HJRGBA(204, 204, 204, 1.0);
    _placeholerLabel.font = [UIFont systemFontOfSize:14];
    [_textV addSubview:_placeholerLabel];
    
}
@end
