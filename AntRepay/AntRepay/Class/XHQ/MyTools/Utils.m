//
//  Utils.m
//  Medical_Wisdom
//
//  Created by Mac on 14-1-26.
//  Copyright (c) 2014年 NanJingXianLang. All rights reserved.
//

#import "Utils.h"

//#import "AppDelegate.h"
@interface Utils ()<UISearchBarDelegate>

@end

@implementation Utils

/*
 AppDelegate
 */

+ (void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
        //设置字号
        [str addAttribute:NSFontAttributeName value:font range:range];
        //设置文字颜色
        [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
        label.attributedText = str;
}
+ (AppDelegate *)applicationDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame withImage:(UIImage *)image{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

+ (UIImageView *)imageViewWithImage:(UIImage *)image{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}

+ (UIImageView *)imageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}

+ (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title titleFontSize:(CGFloat)font textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor alignment:(NSTextAlignment)textAlignment{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = kFont(font);
    label.textColor = color;
    label.backgroundColor = bgColor;
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *)labelWithTitle:(NSString *)title titleFontSize:(CGFloat )font textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor alignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = kFont(font);
    label.textColor = color;
    label.backgroundColor = bgColor;
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *_Nullable)labelWithTitleFontSize:(CGFloat )font
                                   textColor:(UIColor *_Nullable)color
                                   alignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kFont(font);
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}

+ (UILabel *_Nullable)labelWithTitleBlodFontSize:(CGFloat )font
                                       textColor:(UIColor *_Nullable)color
                                       alignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kBlodFont(font);
    label.textColor = color;
    label.textAlignment = textAlignment;
    return label;
}

+ (void)buttonShuXingSetting:(UIButton *)btn{
    CGFloat imageWidth = btn.imageView.bounds.size.width;
    CGFloat labelWidth = btn.titleLabel.bounds.size.width;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
}

+ (UIButton *)createBtnWithType:(UIButtonType)btnType frame:(CGRect)btnFrame backgroundColor:(UIColor*)bgColor title:(NSString *)title image:(NSString *)image font:(CGFloat)font{
    UIButton *btn = [UIButton buttonWithType:btnType];
    btn.frame = btnFrame;
    btn.titleLabel.font = kFont(font);
    
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setBackgroundColor:bgColor];
    return btn;
}

+(UIButton *_Nullable)createBtnWithType:(UIButtonType)btnType
                        backgroundColor:(UIColor*_Nullable)bgColor
                                 action:(SEL _Nullable )action
                                 target:(id _Nullable )target
                                  title:(NSString *_Nullable)title
                                  image:(NSString *_Nullable)image
                                   font:(CGFloat)font
                              textColor:(UIColor *_Nullable)textColor{
    UIButton *btn = [UIButton buttonWithType:btnType];
    btn.titleLabel.font = kFont(font);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setBackgroundColor:bgColor];
    return btn;
}

/**
 * 带渐变色及事件的button
 */
+(UIButton *_Nullable)createJianBianBtnWithType:(UIButtonType)btnType
                                          frame:(CGRect)btnFrame
                                         action:(SEL _Nullable )action
                                         target:(id _Nullable )target
                                          title:(NSString *_Nullable)title
                                          image:(NSString *_Nullable)image
                                           font:(CGFloat)font
                                      textColor:(UIColor *_Nullable)textColor{
    UIButton *btn = [UIButton buttonWithType:btnType];
    btn.frame = btnFrame;
    // 设置渐变色
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = btn.bounds;
//    gradient.startPoint = CGPointMake(0, 0);
//    gradient.endPoint = CGPointMake(1, 0);
//    // 三个颜色组
//    gradient.colors = [NSArray arrayWithObjects:(id)UIColorFromHex(0xfe5352).CGColor,(id)redTextColor.CGColor, nil];
//    //    gradient.locations = @[@(0.4f),@(0.5f),@(0.8f),@(1.0f)];
//    [btn.layer addSublayer:gradient];
    btn.titleLabel.font = kFont(font);
    btn.backgroundColor = [UIColor xhq_base];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    
    return btn;
}

+ (UIBarButtonItem *)initUILeftAddTarget:(id)selfes leftaction:(SEL)action rightAddTarget:(id)rightSelfes rightaction:(SEL)rightAction rightImage:(UIImage *)rightImage leftImage:(UIImage *)leftImage frame:(CGRect)frame{
    UIToolbar *tools = [[UIToolbar alloc]initWithFrame:frame];
    //解决出现的那条线
    tools.clipsToBounds = YES;
    //解决tools背景颜色的问题
    [tools setBackgroundImage:[UIImage new]forToolbarPosition:UIBarPositionAny                      barMetrics:UIBarMetricsDefault];
    [tools setShadowImage:[UIImage new]
       forToolbarPosition:UIToolbarPositionAny];
    
    //添加两个button
    NSMutableArray *buttons = [[NSMutableArray alloc]initWithCapacity:2];
    
    UIBarButtonItem *button3 = [[UIBarButtonItem alloc]initWithImage:rightImage style: UIBarButtonItemStyleDone target:selfes action:action];
    
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc]initWithImage:leftImage style: UIBarButtonItemStyleDone target:rightSelfes action:rightAction];
    
    button3.tintColor = [UIColor whiteColor];
    button2.tintColor = [UIColor whiteColor];
    [buttons addObject:button3];
    [buttons addObject:button2];
    [tools setItems:buttons animated:NO];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:tools];
    return btn;
}


+ (UIButton *)createBtnWithType:(UIButtonType)btnType backgroundColor:(UIColor*)bgColor title:(NSString *)title image:(NSString *)image font:(CGFloat)font{
    UIButton *btn = [UIButton buttonWithType:btnType];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.titleLabel.font = kFont(font);
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setBackgroundColor:bgColor];
    return btn;
    
}

+ (UIButton *)createBtnWithType:(UIButtonType)btnType backgroundColor:(UIColor*)bgColor title:(NSString *)title image:(NSString *)image font:(CGFloat)font textColor:(UIColor *)textColor{
    UIButton *btn = [UIButton buttonWithType:btnType];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.titleLabel.font = kFont(font);
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setBackgroundColor:bgColor];
//    btn.titleLabel.textColor = textColor;
    [btn setTitleColor:textColor forState:(UIControlStateNormal)];
    return btn;
}

+ (UITableView *)setTableViewWithFrame:(CGRect)rect uitableViewStyle:(UITableViewStyle)style  identifier:(NSString *)identifierString{
    UITableView *myTabelView = [[UITableView alloc]initWithFrame:rect style:style];
    myTabelView.tableFooterView = [UIView new];
    return myTabelView;
}

//利用正则表达式验证邮箱的合法性
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//身份证号判断
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

#pragma mark ---- 时间戳转化
+ (NSString *)shiJianChuo:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString *)shiJianChuoJingQue:(NSString *)timeStr style:(NSString *)style{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:style]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


- (void)requestDataWithURL:(NSString *)urlStr success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success falue:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))falue{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        falue(task,error);
        
     }];
}

//银行卡号判断
+ (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

//手机号码验证
+ (BOOL)validatePhone:(NSString *)phone
{
    NSString *phoneRegex = @"^1[3-9]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

//是否是汉字
+ (BOOL)isChinese:(NSString *)string
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:string];
}

//输入限制
+ (BOOL)validateInput:(NSString*)number limit:(NSString *)limit{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:limit];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

//空字符串的判断
+ (BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return NO;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if (object==nil){
        return NO;
    }
    return YES;
}

//md5加密
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString format:(NSString *)format{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString integerValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)ChangeStringTimeFormat:(NSString *)string withFormatter:(NSString *)dateFormat {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate:date];
    //    date = [date dateByAddingTimeInterval:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (UIView *)setSearchBarWithnavigationItem:(UIBarButtonItem *)rightBarButtonItem navView:(UIView *)navTitleView placeholder:(NSString *)placeholder rightBarButtonItemTitle:(NSString *)item target:(id)targetSelf action:(SEL)clickAction{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(64, 7, kScreenWidth- 64 * 2, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-10, 0, titleView.frame.size.width, 30)];
    
    searchBar.placeholder = placeholder;
    searchBar.delegate = targetSelf;
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 5;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    [titleView addSubview:searchBar];
    navTitleView = titleView;
    rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:item style:UIBarButtonItemStyleDone target:targetSelf action:clickAction];
    rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    return titleView;
}

#pragma mark ---- 倒计时
+ (void)getTimeWithButton:(UIButton *)getCodeBtn{
    
    __block int timeout=59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [getCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                getCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            // int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [getCodeBtn setTitle:[NSString stringWithFormat:@"剩余%@秒",strTime] forState:UIControlStateNormal];
                
                getCodeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


+(UIAlertController *)alertCreateTitle:(NSString *)title
                            andMassage:(NSString *)massage {
    
    return [self alertActionCreateTitle:title andMassage:massage setActionEnterText:nil setActionCancelText:@"确定" setEnterAction:nil];
}

+(UIAlertController *)alertOneAcitonCreateTitle:(NSString *)title
                                     andMassage:(NSString *)massage
                             setActionEnterText:(NSString *)enterTitle
                                 setEnterAction:(void(^)(UIAlertAction * action))handler {
    
    return [self alertActionCreateTitle:title andMassage:massage setActionEnterText:enterTitle setActionCancelText:nil setEnterAction:handler];
}


+(UIAlertController *)alertActionCreateTitle:(NSString *)title
                                  andMassage:(NSString *)massage
                          setActionEnterText:(NSString *)enterTitle
                         setActionCancelText:(NSString *)cancelTitle
                              setEnterAction:(void(^)(UIAlertAction * action))handler {
    
    //    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title
    //                                                                    message:massage preferredStyle:UIAlertControllerStyleAlert];
    //
    //    if (cancelTitle) {
    //        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelTitle
    //                                                                style:UIAlertActionStyleDefault handler:nil];
    //        [alert addAction:actionCancel];
    //    }
    //
    //    if (enterTitle) {
    //        UIAlertAction * actionEnter = [UIAlertAction actionWithTitle:enterTitle
    //                                               style:UIAlertActionStyleDestructive
    //                                             handler:handler];
    //        [alert addAction:actionEnter];
    //    }
    //
    //    return alert;
    
    return [self alertActionCreateTitle:title andMassage:massage setActionEnterText:enterTitle setActionCancelText:cancelTitle setEnterAction:handler setCancelAction:nil];
}

+(UIAlertController *)alertActionCreateTitle:(NSString *)title
                                  andMassage:(NSString *)massage
                          setActionEnterText:(NSString *)enterTitle
                         setActionCancelText:(NSString *)cancelTitle
                              setEnterAction:(void(^)(UIAlertAction * action))enterHandler
                             setCancelAction:(void(^)(UIAlertAction * action))cancelHandler {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:massage preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle) {
        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelTitle
                                                                style:UIAlertActionStyleDefault
                                                              handler:cancelHandler];
        [alert addAction:actionCancel];
    }
    
    if (enterTitle) {
        UIAlertAction * actionEnter = [UIAlertAction actionWithTitle:enterTitle
                                                               style:UIAlertActionStyleDestructive
                                                             handler:enterHandler];
        [alert addAction:actionEnter];
    }
    
    return alert;
    
}

//获取当前系统时间的时间戳

#pragma mark - 获取当前时间的 时间戳

+(NSInteger)getNowTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    
    
    
//    GLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    
//    GLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    
    return timeSp;
    
}



//将某个时间转化成 时间戳

#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
//    GLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    return timeSp;
}



//将某个时间戳转化成 时间

#pragma mark - 将某个时间戳转化成 时间

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
//    GLog(@"1296035591  = %@",confromTimesp);
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
    
}

// 将秒转化为时间
+ (NSString *)returndate:(NSNumber *)num{
    
    NSString *str1=[NSString stringWithFormat:@"%@",num];
    
    int x=[[str1 substringToIndex:10] intValue];
    
    NSDate  *date1 = [NSDate dateWithTimeIntervalSince1970:x];
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return [dateformatter stringFromDate:date1];
    
}

// 判断时间
+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    
    NSDate * nowDate = [NSDate date];
    
    //  将需要转换的时间转换成 NSDate 对象
    NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
    //  取当前时间和转换时间两个日期对象的时间间隔
    //  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
    NSTimeInterval currenttime = [nowDate timeIntervalSinceDate:needFormatDate];
    int time = currenttime;
    // 再然后，把间隔的秒数折算成天数和小时数：
    NSString *dateStr = @"";
    
    if (time<=60) {  // 1分钟以内的
        dateStr = NSStringFormat(@"%d",time);
    }else if(time<=60*60){  //  一个小时以内的
        
        int mins = time/60;
        int seds = time%60;
        dateStr = [NSString stringWithFormat:@"%d分%d秒",mins, seds];
        
    }else if(time<=60*60*24){   // 在两天内的
        
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
        NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([need_yMd isEqualToString:now_yMd]) {
            // 在同一天
            //            int hour = time/60/60;
            //            int mins = time/60/60;
            //            int seds = time/60%60;
            dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
        }
        else{
            //  昨天
            dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
        }
    }else if(time<=60*60*24*7){
        dateStr = @"星期";
    }else {
        
        [dateFormatter setDateFormat:@"yyyy"];
        NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
        NSString *nowYear = [dateFormatter stringFromDate:nowDate];
        
        if ([yearStr isEqualToString:nowYear]) {
            //  在同一年
            [dateFormatter setDateFormat:@"MM月dd日"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }else{
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
    }
    return dateStr;
}

// 将豪秒数转化为时间
+ (NSString *)getWorkTimeByString:(NSString *)time{
    
    NSInteger allTime = [time integerValue];
    
    NSInteger years = allTime/1000/60/60/24/365;
    
    NSInteger months = (allTime - years * 365 * 24 * 60 * 60 * 1000)/1000/60/60/24/30;
    
    NSInteger days = (allTime - years * 365 * 24 * 60 * 60 * 1000 - months * 30 * 24 * 60 * 60 * 1000)/1000/60/60/24;
    
    NSInteger hours = (allTime - years * 365 * 24 * 60 * 60 * 1000 - months * 30 * 24 * 60 * 60 * 1000 - days * 24 * 60 * 60 * 1000 )/1000/60/60;
    
    NSInteger minutes = (allTime - years * 365 * 24 * 60 * 60 * 1000 - months * 30 * 24 * 60 * 60 * 1000 - days * 24 * 60 * 60 * 1000 - hours  * 60 *60 * 1000 )/1000/60;
    
    NSInteger seconds = (allTime - years * 365 * 24 * 60 * 60 * 1000 - months * 30 * 24 * 60 * 60 * 1000 - days * 24 * 60 * 60 * 1000 - hours  * 60 *60 * 1000 - minutes * 60 * 1000)/1000;
    
    
    NSString *workTime;
    
    if (years != 0) {
        
        workTime = [NSString stringWithFormat:@"%ld年%ld月%ld天%ld时%ld分%ld秒",(long)years,(long)months,(long)days,(long)hours,(long)minutes, (long)seconds];
        
    }else if (years == 0 && months != 0){
        
        workTime = [NSString stringWithFormat:@"%ld月%ld天%ld时%ld分%ld秒",(long)months,(long)days,(long)hours, (long)minutes, (long)seconds];
    }else if (years == 0 && months == 0 && days != 0){
        
        workTime = [NSString stringWithFormat:@"%ld天%ld时%ld分%ld秒",(long)days,(long)hours, (long)minutes, (long)seconds];
    }else{
        
        workTime = [NSString stringWithFormat:@"%ld小时",(long)hours];
    }
    
    return workTime;
    
}


@end
