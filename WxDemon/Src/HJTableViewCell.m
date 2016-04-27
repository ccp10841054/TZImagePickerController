//
//  HJTableViewCell.m
//  HJPhotoPikerDemo
//
//  Createdby feng on 16/4/10.
//  Copyright© 2016年 feng. All rights reserved.
//

#import "HJTableViewCell.h"

@implementation HJTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
