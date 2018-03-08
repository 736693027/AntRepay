//
//  DYShowView.m
//  Waiter
//
//  Created by 帝云科技 on 16/10/24.
//  Copyright © 2016年 diyunkeji. All rights reserved.
//

#import "DYShowView.h"

@interface DYShowView ()

@property (nonatomic,strong) UILabel  *showLabel;
@property (nonatomic,copy) NSString   *showText;
@property (nonatomic,assign) CGFloat viewY;

@end

@implementation DYShowView


+ (void)ShowWithText:(NSString *)text {
    if (text && text.length > 0) {
        [XHQHud text:text];
//        return [[[self alloc] init] ShowWithText:text];
    }
}

- (instancetype)init {
    
    self = [super init];
    if (self) {}
    return self;
}

- (void)ShowWithText:(NSString *)text {
    
    self.showText = text;
    
    [self addSubview:self.showLabel];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.viewY);
    }completion:^(BOOL finished) {
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.5];
    }];
    
}

- (UILabel *)showLabel {
    
    if (!_showLabel) {
        CGSize size = [self textLength:self.showText andFont:kFont(15)];
        CGFloat X = (kScreenWidth - size.width - BILIWIDTH(50))/2;
        self.viewY = size.height + BILIHEIGHT(80);
        
        self.frame = CGRectMake(X, kScreenHeight, size.width + BILIWIDTH(40), size.height + BILIHEIGHT(20));
        
        _showLabel = [MyTools labelCreate:self.bounds
                         setTextAlignment:1
                               setBGColor:[UIColor grayColor]
                             setTextColor:[UIColor whiteColor]
                                  setFont:kFont(15)
                                  setText:self.showText];
        _showLabel.numberOfLines = 0;
        _showLabel.layer.cornerRadius = 5;
        _showLabel.layer.masksToBounds = YES;
    }
    return _showLabel;
}

- (CGSize)textLength:(NSString *)string andFont:(UIFont *)font{
    
    CGSize customSize ;
    customSize.width = kScreenWidth - BILIWIDTH(100);
    customSize.height = 500;
    
    NSDictionary *attribute = @{NSFontAttributeName : font};
    
    CGSize size =
    [string boundingRectWithSize:customSize
                         options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:attribute
                         context:nil].size;
    
    return size;
}

@end
