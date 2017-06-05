//
//  TRZXRZPositionViewController.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/21.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXRZPositionViewController.h"

#import "TRZXCertTitleCell.h"
#import "TRZXCertificationInformationCell.h"
#import "TRZXPositionModel.h"

#import "TRZXLoginLogic.h"

@interface TRZXRZPositionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, strong) NSIndexPath *index;
@property (strong, nonatomic) TRZXRZIformationMode * mode;
@property (strong, nonatomic) NSArray * titleArr;

@end

@implementation TRZXRZPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    [self.view addSubview:self.tableView];
    _mode = [[TRZXRZIformationMode alloc]init];
    [self Position_Api];
}

- (void)Position_Api{
    

    NSDictionary *params = @{
                                    @"requestType":@"Position_Api",
                            @"apiType":@"list",
                            @"type":@""};
    [TRZXNetwork requestWithUrl:nil params:params method:POST cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id object, NSError *error) {
        if ([object[@"status_code"] isEqualToString:@"200"]) {
            _titleArr = [TRZXPositionModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            [_tableView reloadData];
        }
        
    }];
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
    return _titleArr.count+1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 10;
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
    } else {
        TRZXPositionModel *mode = [_titleArr objectAtIndex:indexPath.section-1];
        TRZXCertificationInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXCertificationInformationCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXCertificationInformationCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = mode.name;
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
    if (!(indexPath.section == 0)) {
        [self.delegate pushInformation:cell.titleLabel.text];
        [self.navigationController popViewControllerAnimated:true];
    }
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



