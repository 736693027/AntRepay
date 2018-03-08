//
//  DYExtendListView.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYExtendModel.h"

@interface DYExtendListView : UIView

@end


/**
 推广记录标题
 */
@interface DYExtendListSectonView : UIView

@end

/**
 推广记录列表
 */
@interface DYExtendListCell : DYTableViewCell

@property (nonatomic, strong) DYExtendListModel *listModel;

@end
