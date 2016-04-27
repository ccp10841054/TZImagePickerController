//
//  HJInputView.h
//  AINursing
//
//  Created by feng on 16/4/10.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    FROM_CONTENT_TEXT,
    FROM_TITLE_TEXT,
} FROM_TEXT;

@interface HJInputView : UIView
/** intputTextView*/
@property(nonatomic,strong)UITextView *textV;
/** placeholderLabel*/
@property(nonatomic,strong)UILabel *placeholerLabel;

- (instancetype)initWithPlaceString:(NSString*)str From:(FROM_TEXT)from;
@end
