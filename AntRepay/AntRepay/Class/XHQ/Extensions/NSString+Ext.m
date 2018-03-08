//
//  NSString+Ext.m
//  Excellence
//
//  Created by 帝云科技 on 2017/7/4.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "NSString+Ext.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (Ext)

- (BOOL)xhq_notEmpty {
    if (self.length == 0) {
        return NO;
    }else {
        NSString *string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
        return string.length == 0 ? NO : YES;
    }
}

- (BOOL)xhq_notEmptyTip:(NSString *)tip {
    BOOL res = [self xhq_notEmpty];
    if (!res) {
        [XHQHud text:[NSString stringWithFormat:@"%@不能为空",tip]];
    }
    return res;
}



- (BOOL)xhq_phoneFormatCheck {
    
    NSString *regex = @"^1[3-9]\\d{9}$";
    return [self xhq_predicateMatches:regex];
}

- (BOOL)xhq_phoneFormatCheckTip:(NSString *)tip {
    
    BOOL res = [self xhq_notEmptyTip:tip];
    if (!res) {
        return res;
    }
    
    res = [self xhq_phoneFormatCheck];
    if (!res) {
        [XHQHud text:[NSString stringWithFormat:@"%@格式不正确",tip]];
    }
    return res;
}



- (BOOL)xhq_idFormatCheck {
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self xhq_predicateMatches:regex];
}

- (BOOL)xhq_idFormatCheckTip:(NSString *)tip {
    BOOL res = [self xhq_notEmptyTip:tip];
    if (!res) {
        return res;
    }
    res = [self xhq_idFormatCheck];
    if (!res) {
        [XHQHud text:[NSString stringWithFormat:@"%@格式不正确",tip]];
    }
    return res;
}



- (BOOL)xhq_emailFormatCheck {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self xhq_predicateMatches:regex];
}

- (BOOL)xhq_emailFormatCheckTip:(NSString *)tip {
    
    BOOL res = [self xhq_notEmptyTip:tip];
    if (!res) {
        return res;
    }
    res = [self xhq_emailFormatCheck];
    if (!res) {
        [XHQHud text:[NSString stringWithFormat:@"%@格式不正确",tip]];
    }
    return res;
}



- (BOOL)xhq_bankCardFormatCheck {
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[self length];
    int lastNum = [[self substringFromIndex:cardNoLength-1] intValue];
    
    NSString *cardNo = [self substringToIndex:cardNoLength - 1];
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

- (BOOL)xhq_bankCardFormatCheckTip:(NSString *)tip {
    
    BOOL res = [self xhq_notEmptyTip:tip];
    if (!res) {
        return res;
    }
    
    res = [self xhq_bankCardFormatCheck];
    if (!res) {
        [XHQHud text:[NSString stringWithFormat:@"%@格式不正确",tip]];
    }
    return res;
}



- (BOOL)xhq_cnNameFormatCheck {
    NSString * regex = @"^[\u4E00-\u9FA5]*$";
    return [self xhq_predicateMatches:regex];
}

- (BOOL)xhq_cnNameFormatCheckTip:(NSString *)tip {
    BOOL res = [self xhq_notEmptyTip:tip];
    if (!res) {
        return res;
    }
    
    res = [self xhq_cnNameFormatCheck];
    if (!res) {
        [XHQHud text:[NSString stringWithFormat:@"%@格式不正确",tip]];
    }
    return res;
}

- (BOOL)xhq_predicateMatches:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}


- (instancetype)xhq_hiddenPhoneFormat {
    if (self.length != 11) {
        return self;
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

- (instancetype)xhq_timeIntervalToStringFromatter:(NSString *)formatter {
    if ([self containsString:@"-"]) {
        return self;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (BOOL)xhq_notEmpty:(NSString *)string {
    BOOL res = [self xhq_notNULL:string];
    if (!res) {
        return NO;
    }
    return [string xhq_notEmpty];
}

+ (BOOL)xhq_notEmpty:(NSString *)string tip:(NSString *)tip {
    BOOL res = [self xhq_notNULL:string tip:tip];
    if (!res) {
        return NO;
    }
    return [string xhq_notEmptyTip:tip];
}

+ (BOOL)xhq_phoneFormatCheck:(NSString *)string tip:(NSString *)tip {
    BOOL res = [self xhq_notNULL:string tip:tip];
    if (!res) {
        return NO;
    }
    return [string xhq_phoneFormatCheckTip:tip];
}

+ (BOOL)xhq_idFormatCheck:(NSString *)string tip:(NSString *)tip {
    BOOL res = [self xhq_notNULL:string tip:tip];
    if (!res) {
        return NO;
    }
    return [string xhq_idFormatCheckTip:tip];
}

+ (BOOL)xhq_emailFormatCheck:(NSString *)string tip:(NSString *)tip {
    BOOL res = [self xhq_notNULL:string tip:tip];
    if (!res) {
        return NO;
    }
    return [string xhq_emailFormatCheckTip:tip];
}

+ (BOOL)xhq_bankCardFormatCheck:(NSString *)string tip:(NSString *)tip {
    BOOL res = [self xhq_notNULL:string tip:tip];
    if (!res) {
        return NO;
    }
    return [string xhq_bankCardFormatCheckTip:tip];
}

+ (BOOL)xhq_cnNameFormatCheck:(NSString *)string tip:(NSString *)tip {
    BOOL res = [self xhq_notNULL:string tip:tip];
    if (!res) {
        return NO;
    }
    return [string xhq_cnNameFormatCheckTip:tip];
}

+ (NSString *)xhq_MD5Encryption:(NSString *)string {
    BOOL res = [self xhq_notEmpty:string];
    if (!res) {
        return @"";
    }
    
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
}

+ (BOOL)xhq_notNULL:(NSString *)str {
    if ([str isEqual:[NSNull null]] ||
        [str isKindOfClass:[NSNull class]] ||
        !str) {
        return NO;
    }
    return YES;
}

+ (BOOL)xhq_notNULL:(NSString *)str tip:(NSString *)tip {
    if ([str isEqual:[NSNull null]] ||
        [str isKindOfClass:[NSNull class]] ||
        !str) {
        [XHQHud text:[NSString stringWithFormat:@"%@不能为空",tip]];
        return NO;
    }
    return YES;
}

+ (instancetype)xhq_nilToInstance:(NSString *)str {
    BOOL res = [self xhq_notNULL:str];
    if (!res) {
        return @"";
    }
    return str;
}


@end


#pragma mark - URL
@implementation NSString (XHQ_URL)

#pragma mark - url解码
+ (NSString*)xhq_URLDecodedString:(NSString*)str {
    NSString*decodedString=(__bridge_transfer NSString*) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef) str,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

#pragma mark - url编码
+ (NSString *)xhq_URLEncodedString:(NSString *)str {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

@end
