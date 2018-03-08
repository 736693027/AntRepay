//
//  cxl_urlHeader.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/22.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#ifndef cxl_urlHeader_h
#define cxl_urlHeader_h
//莉莉莉莉

static NSString *const _url_xxx = @"";

#pragma mark - *******账户

// 我的账户 - 首页
static NSString *const _url_mine_hp = @"Account/index";

// 提现信息
static NSString *const _url_tiXian_message = @"Cash/info";

// 提现
static NSString *const _url_tiXian = @"Cash/apply";

// 提现记录
static NSString *const _url_tiXian_record = @"Cash/log";

// 我的账单 - 资金流水 - 列表
static NSString *const _url_zhangDan_list = @"Money/index";

// 我的账单 - 资金流水 - 详情
static NSString *const _url_zhangDan_detail = @"Money/info";

// 实名认证 - 图片获取
static NSString *const _url_auth_get_image = @"Realname/member_image";

// 实名认证 - 图片上传
static NSString *const _url_auth_image = @"Realname/image";

// 基本资料
static NSString *const _url_basic_data = @"Account/info";

// 基本资料 - 头像上传
static NSString *const _url_basic_icon = @"Account/avatar";

// 基础资料 - 性别修改
static NSString *const _url_basic_sex = @"Account/sex";

// 基础资料 - 昵称修改
static NSString *const _url_basic_nick = @"Account/nickname";

// 修改密码
static NSString *const _url_change_pwd = @"Password/modify";

// 设置 - 客服
static NSString *const _url_kefu = @"Setting/server";

// 关于 - 信息
static NSString *const _url_about = @"About/info";

// 用户须知 - 列表
static NSString *const _url_yhXuZhi_list = @"Notice/index";

//注意事项
static NSString *const _url_notice_thing = @"Notice/thing";

// 用户须知 - 详情
static NSString *const _url_yhXuZhi_detail = @"Notice/info";

// 公告 - 列表
static NSString *const _url_gongGao_list = @"News/index";

// 公告 - 详情
static NSString *const _url_gongGao_detail = @"News/info";

// 消息 - 列表
static NSString *const _url_message_list = @"Message/index";

// 消息 - 详情
static NSString *const _url_message_detail = @"Message/info";

#endif /* cxl_urlHeader_h */
