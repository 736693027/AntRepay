//
//  DYMyExtendView.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/22.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYExtendModel.h"

@interface DYMyExtendView : UIView

@end

typedef void(^DYMyExtendUserViewShareBlock)(void);
typedef void(^DYMyExtendUserViewMoreBlock)(void);
/**
 用户页面
 */
@interface DYMyExtendUserView : UIView

@property (nonatomic, copy) DYMyExtendUserViewShareBlock shareBlock;
@property (nonatomic, copy) DYMyExtendUserViewMoreBlock moreBlock;
@property (nonatomic, strong) DYExtendModel *extendModel;

@end

typedef void(^DYMyExtendSalesmanViewShareBlock)(void);
typedef void(^DYMyExtendSalesmanViewMoreBlock)(void);
/**
 业务员页面
 */
@interface DYMyExtendSalesmanView : UIView

@property (nonatomic, copy) DYMyExtendSalesmanViewShareBlock shareBlock;
@property (nonatomic, copy) DYMyExtendSalesmanViewMoreBlock moreBlock;
@property (nonatomic, strong) DYExtendModel *extendModel;

@end



/**
 邀请记录标题
 */
@interface DYMyExtendSectionHeaderView : UIView

@property (nonatomic, assign) BOOL isUser;

@end


/**
 邀请记录
 */
@interface DYMyExtendListCell : DYTableViewCell

@property (nonatomic, assign) BOOL isUser;

@property (nonatomic, strong) DYExtendListModel *listModel;

@end
