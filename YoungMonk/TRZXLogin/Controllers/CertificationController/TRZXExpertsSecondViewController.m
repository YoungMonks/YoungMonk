//
//  TRZXExpertsSecondViewController.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/20.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXExpertsSecondViewController.h"

#import "TRZXCertTitleCell.h"
#import "TRZXCertificationInformationCell.h"
#import "TRZXPushLabelCell.h"

#import "TRZXRZIformationMode.h"
#import "TRZXRZBasicInformationVC.h"
#import "TRZXCerticationImageViewController.h"
#import "TRZXLoginLogic.h"
#import "TRZXCityViewController.h"

@interface TRZXExpertsSecondViewController ()<UITableViewDelegate,UITableViewDataSource,informationDelegate,cityDelegate>

@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, strong) NSIndexPath *index;
@property (strong, nonatomic) TRZXRZIformationMode * mode;
@property (strong, nonatomic) NSArray * titleArr;


@end

@implementation TRZXExpertsSecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    [self.view addSubview:self.tableView];
    _mode = [[TRZXRZIformationMode alloc]init];
    _titleArr = @[@"",@"职业",@"职位",@"服务行业",@"公司名称",@"公司所在地",@""];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = backColor;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 10;
    } else if (indexPath.section == 6) {
        return 80;
    } else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TRZXCertTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXCertTitleCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXCertTitleCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = backColor;
        return cell;
    } else if (indexPath.section == 6) {
        TRZXPushLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXPushLabelCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXPushLabelCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = backColor;
        return cell;
    } else {
        TRZXCertificationInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXCertificationInformationCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXCertificationInformationCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = _titleArr[indexPath.section];
        cell.mode = _mode;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRZXCertificationInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _index = indexPath;
    //跳转
    if ((indexPath.section == 2||indexPath.section == 4)) {
        TRZXRZBasicInformationVC *viewController = [[TRZXRZBasicInformationVC alloc] init];
        viewController.titleStr = cell.titleLabel.text;
        if ([cell.titleLabel.text isEqualToString:@"姓名"]) {
            viewController.textFieldStr = _mode.name;
        } else if ([cell.titleLabel.text  isEqualToString:@"性别"]) {
            viewController.textFieldStr = _mode.sex;
        } else if ([cell.titleLabel.text  isEqualToString:@"身份证"]) {
            viewController.textFieldStr = _mode.idCard;
        }
        viewController.delegate = self;
        [self.navigationController pushViewController: viewController animated:true];
    }else if ((indexPath.section == 1||indexPath.section == 3)) {
        TRZXRZBasicInformationVC *viewController = [[TRZXRZBasicInformationVC alloc] init];
        viewController.titleStr = cell.titleLabel.text;
        if ([cell.titleLabel.text isEqualToString:@"姓名"]) {
            viewController.textFieldStr = _mode.name;
        } else if ([cell.titleLabel.text  isEqualToString:@"性别"]) {
            viewController.textFieldStr = _mode.sex;
        } else if ([cell.titleLabel.text  isEqualToString:@"身份证"]) {
            viewController.textFieldStr = _mode.idCard;
        }
        viewController.delegate = self;
        [self.navigationController pushViewController: viewController animated:true];
    }else if (indexPath.section == 5) {
        TRZXCityViewController *viewController = [[TRZXCityViewController alloc] init];
        viewController.delegate = self;
        viewController.titleStr = cell.titleLabel.text;
        [self.navigationController pushViewController: viewController animated:true];
    }else if (indexPath.section == 6){
        //下一步
        TRZXCerticationImageViewController *viewController = [[TRZXCerticationImageViewController alloc] init];
        viewController.titleStr = _titleStr;
        [self.navigationController pushViewController: viewController animated:true];
    }
}
-(void)pushInformation:(NSString *)informationStr{
    if (_index.section == 1) {
        _mode.name = informationStr;
    } else if (_index.section == 2) {
        _mode.sex = informationStr;
    } else if (_index.section == 3) {
        _mode.idCard = informationStr;
    }
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:_index.section];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
//城市
- (void)pushCity:(NSArray *)cityArr{


    _mode.city = [cityArr firstObject];
    _mode.cityId = [cityArr lastObject];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:_index.section];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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


