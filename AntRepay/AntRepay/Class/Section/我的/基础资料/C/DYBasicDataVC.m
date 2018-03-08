//
//  DYBasicDataVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYBasicDataVC.h"
#import "DYBasicCell.h"
#import "BDImagePicker.h"
#import "DYNickNameVC.h"
#import "UIViewController+Ext.h"

@interface DYBasicDataVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSString *genderStr;
@property (nonatomic, strong) NSDictionary *basicDic; // 基本资料
@end

@implementation DYBasicDataVC

-(NSDictionary *)basicDic{
    if (!_basicDic) {
        _basicDic = [NSDictionary dictionary];
    }
    return _basicDic;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
        _titleArray = @[@"头像",@"真实姓名",@"身份证号",@"手机号码",@"昵称",@"性别"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dy_reloadData {
    [[DYAppContext sharedDYAppContext] reloadUserInfoCompletion:^{
        [self.tableView reloadData];
    }];
}

-(void)dy_initUI{
    [super dy_initUI];
    self.navigationItem.title = @"基础资料";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYAppUser *appUser = [[DYAppContext sharedDYAppContext] appUser];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DYBasicIconCell *cell = [DYBasicIconCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setValueWithTitle:self.titleArray[indexPath.row]];
            [cell setValueWithString:appUser.avatar];
            @weakify(self);
            // 更换头像
            cell.iconBlock = ^{
                @strongify(self);
                // 选择用户头像
                [BDImagePicker showImagePickerFromViewController:self allowsEditing:NO finishAction:^(UIImage *image) {
                    if (image) {
                        // 更改用户头像
                        [self requestIconDataWithImage:image];
                    }
                }];
            };
            return cell;
        }else{
            DYBasicCell *cell = [DYBasicCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setValueWithTitle:self.titleArray[indexPath.row]];
            if (indexPath.row == 1) {
                [cell setValueWithString:appUser.realname];
            }else if (indexPath.row == 2){
                NSString *str = appUser.idcard;
                if (str.length) {
                    NSString *headStr = [str substringToIndex:3];
                    NSString *tailStr = [str substringFromIndex:14];
                    [cell setValueWithString:NSStringFormat(@"%@***********%@",headStr,tailStr)];
                }
            }else if (indexPath.row == 3){
                NSString *str = appUser.phone;
                if (str.length) {
                    NSString *headStr = [str substringToIndex:3];
                    NSString *tailStr = [str substringFromIndex:7];
                    [cell setValueWithString:NSStringFormat(@"%@****%@",headStr,tailStr)];
                }
            }
            
            return cell;
        }
    }else if (indexPath.section == 1){
        DYBasicThirdCell *cell = [DYBasicThirdCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setValueWithTitle:self.titleArray[indexPath.row+4]];
        if (indexPath.row == 0) {
            [cell setValueWithString:appUser.nickname];
        }else if (indexPath.row == 1) {
            NSString *sex = [appUser.sex integerValue] == 0 ? @"保密" : [appUser.sex integerValue] == 1 ? @"男" : [appUser.sex integerValue] == 2 ? @"女" : @"未设置";
            [cell setValueWithString:sex];
        }
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            DYNickNameVC *vc = [[DYNickNameVC alloc] init];
            PUSHVC(vc);
        }else if (indexPath.row == 1) {
            [self aboutGender];
        }
    }
}

// 性别
- (void)aboutGender{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self requestGenderDataWithGender:@"1"];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self requestGenderDataWithGender:@"2"];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self requestGenderDataWithGender:@"0"];
    }];
    UIAlertAction *cancelACT = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [alertVC addAction:cancelACT];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}

// 修改性别
- (void)requestGenderDataWithGender:(NSString *)gender{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{DY_APP_KEY_VALUE_REQ,
                             @"sex":gender
                             };
    [DYAppReq GET:_url_basic_sex param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                XHQHUDMESSAGE;
                [self dy_reloadData];
            }else{
                XHQHUDMESSAGE;
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

// 更改头像
- (void)requestIconDataWithImage:(UIImage *)image{
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    XHQHUDSHOW(self.view);
    [DYAppReq dy_upload:_url_basic_icon name:@"avatar" image:image param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                XHQHUDTEXT(@"更换头像成功");
                [self dy_reloadData];
            }else {
                XHQHUDMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [DYBasicIconCell cellHeight];
        }else{
            return [DYBasicCell cellHeight];
        }
    }
    return [DYBasicThirdCell cellHeight];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(12))];
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return BILIHEIGHT(12);
    }
    return 0.01;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
