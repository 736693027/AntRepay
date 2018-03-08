//
//  DYHomeCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYHomeCell.h"
#import "DYButtonView.h"
#import "DYHomePageModel.h"

static NSString *const cellIdentifier = @"homeFirstCellIdentifier";
static NSString *const secondCellIdentifier = @"homeSecondCellIdentifier";

@interface DYHomeCell ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *sepatorLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) NSMutableArray *scrollArray;
@end

@implementation DYHomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    [self xhq_noneSelectionStyle];
    _label = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_red] alignment:NSTextAlignmentLeft];
    [self addSubview:_label];
    _label.text = @"公告";
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(8));
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(BILIWIDTH(39));
    }];
    
    _sepatorLabel = [UILabel xhq_lineLabel];
    [self addSubview:_sepatorLabel];
    [_sepatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_label.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(1), BILIHEIGHT(24)));
    }];
    
    _imgView = [Utils imageViewWithImage:kGetImage(@"gongg")];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(13), BILIWIDTH(13)));
        make.left.equalTo(_sepatorLabel.mas_right).offset(BILIWIDTH(7));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _scrollView = [[UIScrollView alloc] init];
    [self addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.userInteractionEnabled = NO;
    _scrollView.delaysContentTouches = NO;
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(BILIWIDTH(82));
        make.width.equalTo(BILIWIDTH(292));
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(1));
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeStar) userInfo:nil repeats:YES];
}


- (void)setNoticeArray:(NSArray *)noticeArray {
    _noticeArray = noticeArray;
    if (noticeArray.count == 0) {
        return;
    }
    [self.scrollArray removeAllObjects];
    for (DYHomePageNoticeModel *model in noticeArray) {
        [_scrollArray addObject:model.title];
    }
    [self scrollViewSubviews];
}


- (NSMutableArray *)scrollArray {
    if (!_scrollArray) {
        _scrollArray = [[NSMutableArray alloc]init];
        [_scrollArray addObject:@"暂无公告"];
    }
    return _scrollArray;
}

- (void)scrollViewSubviews {
    if (self.scrollArray.count == 0) {
        return;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [[_scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger count = _scrollArray.count + 1;
    _scrollView.contentSize = CGSizeMake(0, _scrollView.mj_h * count);
    for (NSInteger index = 0; index < count; index ++) {
        UILabel *titleLabel = ({
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, index * _scrollView.mj_h, _scrollView.mj_w, _scrollView.mj_h)];
            if (index == _scrollArray.count) {
                label.text = _scrollArray[0];
            }else {
                label.text = _scrollArray[index];
            }
            label.textColor = KGrayColor;
            label.font = kFont(12);
            label;
        });
        [_scrollView addSubview:titleLabel];
    }
}


- (void)timeStar {
    [UIView animateWithDuration:0.4 animations:^{
        CGPoint contentOffset = _scrollView.contentOffset;
        contentOffset.y += _scrollView.xhq_height;
        _scrollView.contentOffset = contentOffset;
    } completion:^(BOOL finished) {
        CGPoint contentOffset = _scrollView.contentOffset;
        NSInteger index = (NSInteger)_scrollView.contentOffset.y / _scrollView.xhq_height;
        if (index == _scrollArray.count) {
            contentOffset.y = 0;
            _scrollView.contentOffset = contentOffset;
        }
    }];
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(49);
}

@end


@interface DYHomeSecondCell ()

@property (nonatomic, strong) NSArray *titleArray;

@end

#pragma mark --------------- 选择cell
@implementation DYHomeSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleArray = @[@{@"image":@"zhnghu",@"title":@"我的账户"},
                            @{@"image":@"sqdaik",@"title":@"我的推广"},
                            @{@"image":@"xinyka",@"title":@"关于我们"},
                            @{@"image":@"jinducx",@"title":@"代理加盟"}];
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYHomeSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellIdentifier];
    if (!cell) {
        cell = [[DYHomeSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float width = kScreenWidth/4;
    float height = BILIHEIGHT(85);
    
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        NSInteger row = i/4;
        NSInteger col = i%4;
        DYButtonView *view = [[DYButtonView alloc] initWithImage:self.titleArray[i][@"image"] title:self.titleArray[i][@"title"]];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(col * width);
            make.top.equalTo(self.mas_top).offset(row * (height + BILIHEIGHT(10)) + BILIHEIGHT(15));
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
        }];
        
        [view.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.top.equalTo(view.mas_top).offset(BILIHEIGHT(10));
            make.size.mas_equalTo(CGSizeMake(BILIWIDTH(44), BILIWIDTH(44)));
        }];
        
        [view.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.top.equalTo(view.imgView.mas_bottom).offset(BILIHEIGHT(7));
        }];
        view.titleLabel.textColor = [UIColor xhq_aTitle];
        view.tag = i+1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonClick:)];
        [view addGestureRecognizer:tap];
    }
}

- (void)buttonClick:(UITapGestureRecognizer *)sender {
    HomeType type = (HomeType)sender.view.tag;
    if (self.block) {
        self.block(type);
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(225);
}

@end
