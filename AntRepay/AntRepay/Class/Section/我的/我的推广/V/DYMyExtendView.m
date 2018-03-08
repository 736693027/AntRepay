//
//  DYMyExtendView.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/22.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYMyExtendView.h"

@implementation DYMyExtendView

@end

#pragma mark - DYMyExtendUserView 用户页面
@interface DYMyExtendUserView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *container;

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *QRCodeImageView;
@property (nonatomic, strong) UIImageView *recordImageView;
@property (nonatomic, strong) UIImageView *tableBgImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UILabel *totalLabel;

@end

static NSString *const _image_extend_u_record = @"extend_u_record";
static NSString *const _image_extend_u_share = @"extend_u_share";
static NSString *const _image_extend_u_top = @"extend_u_top";
static NSString *const _image_extend_u_table = @"extend_u_table";

@implementation DYMyExtendUserView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.container];
    [self.container addSubview:self.topImageView];
    [self.container addSubview:self.totalLabel];
    [self.container addSubview:self.QRCodeImageView];
    [self.container addSubview:self.shareButton];
    [self.container addSubview:self.recordImageView];
    [self.container addSubview:self.tableBgImageView];
    [self.container addSubview:self.tableView];
    [self.container addSubview:self.moreButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.bottom.equalTo(_tableBgImageView.bottom).offset(BILIHEIGHT(50));
    }];
    [_topImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(BILIHEIGHT(286));
    }];
    [_QRCodeImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(BILIHEIGHT(210));
        make.size.equalTo(CGSizeMake(BILIHEIGHT(140), BILIHEIGHT(140)));
    }];
    [_shareButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_QRCodeImageView.bottom).offset(BILIHEIGHT(20));
        make.size.equalTo(CGSizeMake(BILIWIDTH(170), BILIHEIGHT(44)));
    }];
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_shareButton.bottom).offset(BILIHEIGHT(30));
    }];
    [_recordImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_totalLabel.bottom).offset(BILIHEIGHT(40));
        make.size.equalTo(CGSizeMake(BILIWIDTH(259), BILIHEIGHT(31)));
    }];
    [_tableBgImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_recordImageView.bottom).offset(BILIHEIGHT(15));
        make.size.equalTo(CGSizeMake(BILIWIDTH(340), BILIHEIGHT(205)));
    }];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_tableBgImageView).offset(CGPointMake(0, -BILIHEIGHT(10)));
        make.size.equalTo(CGSizeMake(BILIWIDTH(280), BILIHEIGHT(150)));
    }];
    [_moreButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.bottom).offset(BILIHEIGHT(10));
        make.right.equalTo(_tableView.right).offset(BILIWIDTH(-10));
        make.size.equalTo(CGSizeMake(BILIWIDTH(80), BILIHEIGHT(20)));
    }];
}

#pragma mark - 分享
- (void)shareButtonClicked {
    if (self.shareBlock) {
        self.shareBlock();
    }
}

#pragma mark - 查看更多
- (void)moreButtonClicked {
    if (self.moreBlock) {
        self.moreBlock();
    }
}

#pragma mark - setter
- (void)setExtendModel:(DYExtendModel *)extendModel {
    _extendModel = extendModel;
    NSString *tip = @"我的收益：";
    _totalLabel.text = [NSString stringWithFormat:@"%@￥%@", tip, extendModel.money];
    [_totalLabel attribute:@{NSForegroundColorAttributeName: [UIColor xhq_content]} range:NSMakeRange(0, tip.length)];
    [_QRCodeImageView sd_setImageWithURL:[NSURL URLWithString:extendModel.qrcode]];
    [self.tableView reloadData];
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc]init];
        _container.backgroundColor = XHQHexColor(0xadd6fc);
    }
    return _container;
}

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_image_extend_u_top]];
    }
    return _topImageView;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [UILabel xhq_layoutColor:[UIColor xhq_base]
                                          font:[UIFont xhq_font14]
                                          text:@"我的收益：￥0.00"];
    }
    return _totalLabel;
}

- (UIImageView *)QRCodeImageView {
    if (!_QRCodeImageView) {
        _QRCodeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _QRCodeImageView.backgroundColor = [UIColor whiteColor];
    }
    return _QRCodeImageView;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setBackgroundImage:[UIImage imageNamed:_image_extend_u_share] forState:UIControlStateNormal];
        [_shareButton xhq_addTarget:self action:@selector(shareButtonClicked)];
    }
    return _shareButton;
}

- (UIImageView *)recordImageView {
    if (!_recordImageView) {
        _recordImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_image_extend_u_record]];
    }
    return _recordImageView;
}

- (UIImageView *)tableBgImageView {
    if (!_tableBgImageView) {
        _tableBgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_image_extend_u_table]];
    }
    return _tableBgImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView xhq_registerCell:[DYMyExtendListCell class]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton xhq_buttonFrame:CGRectZero
                                        bgColor:[UIColor clearColor]
                                     titleColor:XHQHexColor(0xfce56b)
                                    borderWidth:0
                                    borderColor:nil
                                   cornerRadius:0
                                            tag:0
                                         target:self
                                         action:@selector(moreButtonClicked)
                                          title:@"查看更多 >> "];
        _moreButton.xhqFont = XHQ_FONT(BILIWIDTH(12));
    }
    return _moreButton;
}

#pragma mark - tableViewD
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.extendModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYMyExtendListCell *cell = [tableView xhq_dequeueCell:[DYMyExtendListCell class]
                                                indexPath:indexPath];
    cell.isUser = YES;
    cell.listModel = self.extendModel.list[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DYMyExtendSectionHeaderView *view = [[DYMyExtendSectionHeaderView alloc]init];
    view.isUser = YES;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BILIHEIGHT(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return BILIHEIGHT(30);
}

@end



#pragma mark - DYMyExtendSalesmanView 业务员页面
@interface DYMyExtendSalesmanView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *QRCodeBgImageView;
@property (nonatomic, strong) UIImageView *QRCodeImageView;
@property (nonatomic, strong) UIImageView *tableBgImageView;
@property (nonatomic, strong) UIImageView *tableFrontImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UILabel *totalLabel;

@end

static NSString *const _image_extend_s_bg = @"extend_s_bg";
static NSString *const _image_extend_s_table = @"extend_s_table";
static NSString *const _image_extend_s_qr = @"extend_s_qr";
static NSString *const _image_extend_s_table_bg = @"extend_s_table_bg";

@implementation DYMyExtendSalesmanView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.backImageView];
    [self.backImageView addSubview:self.container];
    [self.backImageView addSubview:self.totalLabel];
    [self.backImageView addSubview:self.QRCodeBgImageView];
    [self.backImageView addSubview:self.QRCodeImageView];
    [self.backImageView addSubview:self.shareButton];
    [self.backImageView addSubview:self.tableBgImageView];
    [self.backImageView addSubview:self.tableView];
    [self.backImageView addSubview:self.tableFrontImageView];
    [self.backImageView addSubview:self.moreButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.bottom.equalTo(_container.bottom).offset(BILIHEIGHT(30));
    }];
    UIEdgeInsets containerInsets = UIEdgeInsetsMake(BILIWIDTH(240), BILIHEIGHT(15), 0, BILIWIDTH(15));
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_backImageView).insets(containerInsets);
        make.bottom.equalTo(_tableBgImageView.bottom).offset(BILIHEIGHT(20));
    }];
    [_QRCodeBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.size.equalTo(CGSizeMake(BILIWIDTH(359), BILIHEIGHT(265)));
        make.bottom.equalTo(_container.top).offset(BILIHEIGHT(180));
    }];
    [_QRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.size.equalTo(CGSizeMake(BILIWIDTH(100), BILIHEIGHT(100)));
        make.bottom.equalTo(_QRCodeBgImageView.bottom).offset(BILIHEIGHT(-40));
    }];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.size.equalTo(CGSizeMake(BILIWIDTH(230), BILIHEIGHT(35)));
        make.top.equalTo(_QRCodeBgImageView.bottom).offset(BILIHEIGHT(20));
    }];
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_shareButton.bottom).offset(BILIHEIGHT(30));
    }];
    [_tableBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalLabel.bottom).offset(BILIHEIGHT(30));
        make.centerX.equalTo(0);
        make.size.equalTo(CGSizeMake(BILIWIDTH(314), BILIHEIGHT(226)));
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_tableBgImageView).offset(CGPointMake(0, BILIHEIGHT(10)));
        make.size.equalTo(CGSizeMake(BILIWIDTH(280), BILIHEIGHT(150)));
    }];
    [_tableFrontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(_container);
        make.height.equalTo(BILIHEIGHT(331));
    }];
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.bottom).offset(BILIHEIGHT(0));
        make.right.equalTo(_tableView.right).offset(BILIWIDTH(-10));
        make.size.equalTo(CGSizeMake(BILIWIDTH(80), BILIHEIGHT(20)));
    }];
}

#pragma mark - 分享
- (void)shareButtonClicked {
    if (self.shareBlock) {
        self.shareBlock();
    }
}

#pragma mark - 查看更多
- (void)moreButtonClicked {
    if (self.moreBlock) {
        self.moreBlock();
    }
}

#pragma mark - setter
- (void)setExtendModel:(DYExtendModel *)extendModel {
    _extendModel = extendModel;
    NSString *tip = @"我的收益：";
    _totalLabel.text = [NSString stringWithFormat:@"%@￥%@", tip, extendModel.money];
    [_totalLabel attribute:@{NSForegroundColorAttributeName: [UIColor xhq_content]} range:NSMakeRange(0, tip.length)];
    [_QRCodeImageView sd_setImageWithURL:[NSURL URLWithString:extendModel.qrcode]];
    [self.tableView reloadData];
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_image_extend_s_bg]];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc]init];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.cornerRadius = BILIHEIGHT(5);
        _container.layer.masksToBounds = YES;
    }
    return _container;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [UILabel xhq_layoutColor:[UIColor xhq_base]
                                          font:[UIFont xhq_font14]
                                          text:@"我的收益：￥0.00"];
    }
    return _totalLabel;
}

- (UIImageView *)QRCodeBgImageView {
    if (!_QRCodeBgImageView) {
        _QRCodeBgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_image_extend_s_qr]];
    }
    return _QRCodeBgImageView;
}

- (UIImageView *)QRCodeImageView {
    if (!_QRCodeImageView) {
        _QRCodeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _QRCodeImageView.backgroundColor = [UIColor whiteColor];
    }
    return _QRCodeImageView;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setBackgroundColor:[UIColor xhq_base]];
        [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_shareButton setTitle:@"分享二维码" forState:UIControlStateNormal];
        _shareButton.titleLabel.font = XHQ_FONTBOLD(16);
        [_shareButton.titleLabel wordSpace:2];
        _shareButton.layer.cornerRadius = BILIHEIGHT(5);
        _shareButton.layer.masksToBounds = YES;
        [_shareButton xhq_addTarget:self action:@selector(shareButtonClicked)];
    }
    return _shareButton;
}
- (UIImageView *)tableBgImageView {
    if (!_tableBgImageView) {
        _tableBgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_image_extend_s_table]];
    }
    return _tableBgImageView;
}

- (UIImageView *)tableFrontImageView {
    if (!_tableFrontImageView) {
        _tableFrontImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_image_extend_s_table_bg]];
    }
    return _tableFrontImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView xhq_registerCell:[DYMyExtendListCell class]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton xhq_buttonFrame:CGRectZero
                                        bgColor:[UIColor clearColor]
                                     titleColor:[UIColor xhq_base]
                                    borderWidth:0
                                    borderColor:nil
                                   cornerRadius:0
                                            tag:0
                                         target:self
                                         action:@selector(moreButtonClicked)
                                          title:@"查看更多 >> "];
        _moreButton.xhqFont = XHQ_FONT(BILIWIDTH(12));
    }
    return _moreButton;
}

#pragma mark - tableViewD
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.extendModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYMyExtendListCell *cell = [tableView xhq_dequeueCell:[DYMyExtendListCell class]
                                                indexPath:indexPath];
    cell.isUser = NO;
    cell.listModel = self.extendModel.list[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DYMyExtendSectionHeaderView *view = [[DYMyExtendSectionHeaderView alloc]init];
    view.isUser = NO;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BILIHEIGHT(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return BILIHEIGHT(30);
}

@end


#pragma mark - DYMyExtendSectionHeaderView 邀请记录标题
@interface DYMyExtendSectionHeaderView ()

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation DYMyExtendSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.phoneLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.equalTo(0);
        make.width.equalTo(BILIWIDTH(95));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(_phoneLabel.right).offset(BILIWIDTH(5));
        make.width.equalTo(BILIWIDTH(60));
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(0);
        make.left.equalTo(_nameLabel.right).offset(BILIWIDTH(5));
    }];
}

#pragma mark - setter
- (void)setIsUser:(BOOL)isUser {
    _isUser = isUser;
    _phoneLabel.textColor =
    _nameLabel.textColor =
    _timeLabel.textColor =
    isUser ? [UIColor whiteColor] : [UIColor xhq_aTitle];
}


#pragma mark - getter
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [UILabel xhq_layoutColor:[UIColor whiteColor]
                                          font:XHQ_FONTBOLD(BILIWIDTH(14))
                                          text:@"手机号"];
        _phoneLabel.textAlignment = 1;
    }
    return _phoneLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel xhq_layoutColor:[UIColor whiteColor]
                                         font:XHQ_FONTBOLD(BILIWIDTH(14))
                                         text:@"姓名"];
        _nameLabel.textAlignment = 1;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel xhq_layoutColor:[UIColor whiteColor]
                                         font:XHQ_FONTBOLD(BILIWIDTH(14))
                                         text:@"注册时间"];
        _timeLabel.textAlignment = 1;
    }
    return _timeLabel;
}

@end


#pragma mark - DYMyExtendListCell 邀请记录
@interface DYMyExtendListCell ()

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation DYMyExtendListCell

- (void)dy_initUI {
    [super dy_initUI];
    [self xhq_noneSelectionStyle];
    self.hideSeparatorLabel = YES;
    
    self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.equalTo(0);
        make.width.equalTo(BILIWIDTH(95));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(_phoneLabel.right).offset(BILIWIDTH(5));
        make.width.equalTo(BILIWIDTH(60));
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(0);
        make.left.equalTo(_nameLabel.right).offset(BILIWIDTH(5));
    }];
}

#pragma mark - setter
- (void)setIsUser:(BOOL)isUser {
    _isUser = isUser;
    _phoneLabel.textColor =
    _nameLabel.textColor =
    _timeLabel.textColor =
    isUser ? [UIColor whiteColor] : XHQHexColor(0x926b1a);
}

- (void)setListModel:(DYExtendListModel *)listModel {
    _phoneLabel.text = listModel.phone;
    if ([NSString xhq_notEmpty:listModel.realname]) {
        _nameLabel.text = listModel.realname;
    }
    else {
        _nameLabel.text = @"未实名";
    }
    _timeLabel.text = [listModel.add_time xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd HH:mm"];
}

#pragma mark - getter
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [UILabel xhq_layoutColor:[UIColor whiteColor]
                                          font:XHQ_FONT(BILIWIDTH(12))
                                          text:@"188****8888"];
        _phoneLabel.textAlignment = 1;
    }
    return _phoneLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel xhq_layoutColor:[UIColor whiteColor]
                                         font:XHQ_FONT(BILIWIDTH(12))
                                         text:@"未实名"];
        _nameLabel.textAlignment = 1;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel xhq_layoutColor:[UIColor whiteColor]
                                         font:XHQ_FONT(BILIWIDTH(12))
                                         text:@"2017-12-22 15:01"];
        _timeLabel.textAlignment = 1;
    }
    return _timeLabel;
}

@end
