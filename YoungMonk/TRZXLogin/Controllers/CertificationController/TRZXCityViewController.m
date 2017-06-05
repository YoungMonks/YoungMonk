//
//  TRZXCityViewController.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/25.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXCityViewController.h"
#import "TRZXLoginLogic.h"
#import "TRZXCityModel.h"
#import "TRZXCityTopView.h"
@interface TRZXCityViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *leftTableView;
@property (nonatomic, weak) UITableView *rightTaleView;

//@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSIndexPath *currentSelectIndexPath;

@property (strong, nonatomic) UIButton * rightButton;

@property (strong, nonatomic) NSArray * popArr;

@property (strong, nonatomic) TRZXCityModel *cityMode;

@end

#define ScreenWidth self.view.frame.size.width
#define ScreenHeignt self.view.frame.size.height


@implementation TRZXCityViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self Position_Api];
    self.title = _titleStr;
    self.view.backgroundColor = backColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationController.navigationBar.translucent = NO;
    
    TRZXCityTopView * view1 = [[[NSBundle bundleForClass:[self class]]loadNibNamed:@"TRZXCityTopView" owner:self options:nil] objectAtIndex:0];
    view1.frame = CGRectMake(0, 5, ScreenWidth, 50);
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, ScreenWidth*0.3, ScreenHeignt)];
    leftTableView.showsHorizontalScrollIndicator = NO;
    leftTableView.showsVerticalScrollIndicator = NO;
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:leftTableView];
    self.leftTableView = leftTableView;
    
    UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth*0.3+5, 55, ScreenWidth*0.7-5, ScreenHeignt)];
    rightTableView.showsHorizontalScrollIndicator = NO;
    rightTableView.showsVerticalScrollIndicator = NO;
    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:rightTableView];
    self.rightTaleView = rightTableView;
    
    rightTableView.delegate = leftTableView.delegate = self;
    rightTableView.dataSource = leftTableView.dataSource = self;
}

-(UIButton *)rightButton{
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 35)];
    [_rightButton setTitle:@"完成" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightButton setTitleColor:[UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(pushBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return _rightButton;
}
- (void)Position_Api{
    
    NSDictionary *params = @{
                             @"requestType":@"TradesAndStages_Api",
//                             @"apiType":@"list",
//                             @"type":@""
                             };
    [TRZXNetwork requestWithUrl:nil params:params method:POST cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id object, NSError *error) {
        if ([object[@"status_code"] isEqualToString:@"200"]) {
            _cityMode = [TRZXCityModel mj_objectWithKeyValues:object];
            [self.leftTableView reloadData];
        }
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTableView) {
        return _cityMode.trades.count;
    }
    return _cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize: 15.0];
    cell.textLabel.textColor = [UIColor grayColor];
    if (tableView == _leftTableView) {
        cityData *mode = _cityMode.trades[indexPath.row];
        cell.textLabel.text = mode.trade;
    }else{
        childrenData *model = _cityArray[indexPath.row];
        cell.textLabel.text = model.trade;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _rightTaleView) {
        //行被选中后，自动变回反选状态的方法
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        childrenData *model = _cityArray[indexPath.row];
        _popArr = @[model.trade,model.mid];
        
    }else{
        _currentSelectIndexPath = indexPath;
        cityData *cityData = _cityMode.trades[indexPath.row];
        _cityArray = cityData.children;
        [self.rightTaleView reloadData];
        _popArr = nil;
    }
    
}
//完成事件返回传值
- (void)pushBtnClick:(UIButton *)sender{
    if (_popArr == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择城市" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self.delegate pushCity:_popArr];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
