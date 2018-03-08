//
//  UIColor+Ext.m
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "UIColor+Ext.h"


@implementation UIColor (Ext)

+ (instancetype)xhq_base {
    return XHQHexColor(COLOR_VALUE_BASE);
}

+ (instancetype)xhq_background {
    return XHQHexColor(COLOR_VALUE_BACKGROUND);
}

+ (instancetype)xhq_red {
    return XHQHexColor(COLOR_VALUE_RED);
}

+ (instancetype)xhq_green {
    return XHQHexColor(COLOR_VALUE_GREEN);
}

+ (instancetype)xhq_hexb7 {
    return XHQHexColor(COLOR_VALUE_HEXB7);
}

+ (instancetype)xhq_line {
    return XHQHexColor(COLOR_VALUE_LINE);
}

+ (instancetype)xhq_aTitle {
    return XHQHexColor(COLOR_VALUE_TITLE);
}

+ (instancetype)xhq_content {
    return XHQHexColor(COLOR_VALUE_CONTENT);
}

+ (instancetype)xhq_section {
    return XHQHexColor(COLOR_VALUE_SECTION);
}

@end
