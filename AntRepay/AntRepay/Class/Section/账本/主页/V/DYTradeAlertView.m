//
//  DYTradeAlertView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTradeAlertView.h"
#import "DYBooksModel.h"

@interface DYTradeAlertView ()

@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *valueArray;

@end

@implementation DYTradeAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationStatusHeight, kScreenWidth, kScreenHeight-kNavigationStatusHeight)];
    [self addSubview:_backView];
    _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationStatusHeight + 0.5f, kScreenWidth, 0)];
    _topView.backgroundColor = KWhiteColor;
    _topView.clipsToBounds = YES;
    [self addSubview:_topView];
    [self setupSubviews];
}

- (void)setupSubviews {
    [[self.topView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray *arr = @[@"全部",@"蚂蚁消费", @"蚂蚁还款"];
    if (self.nameArray.count > 0) {
        arr = _nameArray;
    }
    CGFloat totalWidth = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat totalHeight = BILIHEIGHT(10);//用来控制button距离父视图的高
    CGFloat buttonHeigth = BILIHEIGHT(28);
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.titleLabel.font = kFont(14);
        button.tag = 3000 + i;
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:kFont(12)};
        CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(kScreenWidth, buttonHeigth) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        if (i == 0) {
            button.frame = CGRectMake(BILIWIDTH(10), totalHeight, length + BILIHEIGHT(25), buttonHeigth);
        }else{
            button.frame = CGRectMake(BILIWIDTH(10) + totalWidth, totalHeight, length + BILIWIDTH(25) , buttonHeigth);
        }
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(totalWidth + length + BILIWIDTH(25) > kScreenWidth){
            totalWidth = 0; //换行时将w置为0
            totalHeight = totalHeight  + button.xhq_height + BILIHEIGHT(10);//距离父视图也变化
            button.frame = CGRectMake(BILIWIDTH(10) + totalWidth, totalHeight, length + BILIHEIGHT(25), buttonHeigth);//重设button的frame
        }
        totalWidth = button.frame.size.width + button.frame.origin.x;
        
        ViewBorderRadius(button, BILIHEIGHT(5), BILIWIDTH(0.7), KGrayColor);
        [button setTitleColor:[UIColor xhq_aTitle] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor xhq_base] forState:UIControlStateDisabled];
        [self.topView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            _selectedBtn = button;
            button.layer.borderColor = [UIColor xhq_base].CGColor;
        }
    }
}

//点击事件
- (void)handleClick:(UIButton *)button{
    button.enabled = NO;
    _selectedBtn.enabled = YES;
    _selectedBtn.layer.borderColor = KGrayColor.CGColor;
    _selectedBtn = button;
    _selectedBtn.layer.borderColor = [UIColor xhq_base].CGColor;
    if (self.selectedBlock) {
        self.selectedBlock(button.titleLabel.text, [self.valueArray[button.tag - 3000] integerValue]);
    }
}

- (void)pop {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        _topView.xhq_height = BILIHEIGHT(50);
    } completion:^(BOOL finished) {
    }];
}

- (void)hide{
    
    [UIView animateWithDuration:0.3 animations:^{
        _topView.xhq_height = 0.1;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.topView]) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
}

#pragma mark - setter
- (void)setTypeArray:(NSArray *)typeArray {
    _typeArray = typeArray;
    _nameArray = [[NSMutableArray alloc]init];
    _valueArray = [[NSMutableArray alloc]init];
    [_nameArray addObject:@"全部"];
    [_valueArray addObject:@"0"];
    for (DYBooksTypeModel *model in typeArray) {
        [_nameArray addObject:model.name];
        [_valueArray addObject:model.value];
    }
    [self setupSubviews];
}


@end
