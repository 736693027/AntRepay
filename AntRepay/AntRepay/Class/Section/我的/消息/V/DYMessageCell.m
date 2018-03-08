//
//  DYMessageCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYMessageCell.h"
#import "DialogSingleView.h"
#define messageCellHeight BILIHEIGHT(67)

@interface DYMessageCell ()
@property (nonatomic, strong) DialogSingleView *dialogView;
@end

static NSString *const messageCellReuseIdentifier = @"messageCellReuse";

@implementation DYMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellReuseIdentifier];
    if (!cell) {
        cell = [[DYMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageCellReuseIdentifier];
    }
    return cell;
}

// 初始化图形界面
- (void)setupUI{
    _dialogView = [[DialogSingleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, messageCellHeight)];
    [self addSubview:_dialogView];
}

+(CGFloat)cellHeight{
    return messageCellHeight;
}

-(void)setValueWithModel:(DYMessageModel *)model{
    if (model) {
        _dialogView.titleLabel.text = model.title;
        NSString *time = model.time;
        _dialogView.timeLabel.text = [Utils timestampSwitchTime:[time integerValue] andFormatter:@"yyyy-MM-dd HH:mm"];
        _dialogView.contentLable.text = model.content;
        if ([model.read intValue] == 1) {
            [_dialogView.yellowView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_dialogView.mas_top).offset(BILIHEIGHT(16));
                make.left.equalTo(_dialogView.mas_left).offset(BILIWIDTH(10));
                make.width.mas_equalTo(0);
                make.height.mas_equalTo(BILIHEIGHT(6));
            }];
            [_dialogView.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_dialogView.yellowView.mas_right);
                make.top.equalTo(_dialogView.mas_top).offset(BILIHEIGHT(5));
                make.width.mas_equalTo(BILIWIDTH(245));
            }];
        }else{
            [_dialogView.yellowView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_dialogView.mas_top).offset(BILIHEIGHT(16));
                make.left.equalTo(_dialogView.mas_left).offset(BILIWIDTH(10));
                make.width.mas_equalTo(BILIWIDTH(6));
                make.height.mas_equalTo(BILIHEIGHT(6));
            }];
            [_dialogView.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_dialogView.yellowView.mas_right).offset(BILIWIDTH(5));
                make.top.equalTo(_dialogView.mas_top).offset(BILIHEIGHT(5));
                make.width.mas_equalTo(BILIWIDTH(245));
            }];
        }
        CGFloat height = [[NSString getSuitableHeightWithString:_dialogView.titleLabel.text WithWidth:BILIWIDTH(200) WithFont:14] floatValue];
        self.xhq_height = BILIHEIGHT(35) + height;
    }
}

@end
