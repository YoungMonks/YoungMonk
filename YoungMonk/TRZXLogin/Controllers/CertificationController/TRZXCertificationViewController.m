//
//  TRZXCertificationViewController.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/11.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXCertificationViewController.h"
#import "TRZXCertificationHomeCell.h"
#import "TRZXCertificationTopCell.h"
#import "TRZXPushLabelCell.h"

#import "TRZXExpertsCertViewController.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"


@interface TRZXCertificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UIButton * rightButton;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)AppDelegate *appdelegate;


@end

@implementation TRZXCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一键认证";
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.hidesBackButton = YES;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
-(UIButton *)rightButton{
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 35)];
    [_rightButton setTitle:@"跳转" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightButton setTitleColor:[UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(pushBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return _rightButton;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TRZXCertificationTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXCertificationTopCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXCertificationTopCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else {
        TRZXCertificationHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXCertificationHomeCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXCertificationHomeCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.index = indexPath;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转
    if (indexPath.row == 1||indexPath.row == 2||indexPath.row == 3){
        TRZXExpertsCertViewController *viewController = [[TRZXExpertsCertViewController alloc] init];
        if (indexPath.row == 1) {
            viewController.titleStr = @"专家认证";
        }else if (indexPath.row == 2) {
            viewController.titleStr = @"股东认证";
        }else if (indexPath.row == 3){
            viewController.titleStr = @"投资人认证";
        }
        [self.navigationController pushViewController: viewController animated:true];
    }
}
//跳转事件
- (void)pushBtnClick:(UIButton *)sender{
    _appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [_appdelegate enterMainUI];
//    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
