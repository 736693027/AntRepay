//
//  DYTableViewCell.m
//  Excellence
//
//  Created by 帝云科技 on 2017/6/19.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTableViewCell.h"

@implementation DYTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self dy_initUI];
    }
    return self;
}

- (void)dy_initUI {
    [self addSubview:self.separatorLabel];
    self.textLabel.textColor = [UIColor xhq_aTitle];
    self.textLabel.font = [UIFont xhq_font16];
    self.detailTextLabel.textColor = [UIColor xhq_content];
    self.detailTextLabel.font = [UIFont xhq_font14];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.separatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.mas_equalTo(0.7);
    }];
}

- (UILabel *)separatorLabel {
    if (!_separatorLabel) {
        _separatorLabel = [[UILabel alloc]init];
        _separatorLabel.backgroundColor = [UIColor xhq_line];
    }
    return _separatorLabel;
}

- (void)setHideSeparatorLabel:(BOOL)hideSeparatorLabel {
    _hideSeparatorLabel = hideSeparatorLabel;
    _separatorLabel.hidden = hideSeparatorLabel;
}


@end
