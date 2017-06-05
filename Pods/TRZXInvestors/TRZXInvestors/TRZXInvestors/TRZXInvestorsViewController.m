//
//  TRZXHotProjectViewController.m
//  TRZXProject
//
//  Created by N年後 on 2017/2/21.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXInvestorsViewController.h"
#import "TRZXInvestorsViewModel.h"
#import "TRZXInvestorsCell.h"
#import "TRZXKit.h"
#import "TRZXDIYRefresh.h"
#import <TRZXProjectScreeningBusinessCategory/CTMediator+TRZXProjectScreening.h>
#import <TRZXInvestorDetailCategory/CTMediator+TRZXInvestorDetailCategory.h>
@interface TRZXInvestorsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *hotProjectTableView;
@property (strong, nonatomic) TRZXInvestorsViewModel *projectViewModel;
@property (strong, nonatomic) UIViewController *projectScreeningVC; //

@end

@implementation TRZXInvestorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = self.projectTitle;
    [self setRightBarItemImage:[UIImage imageNamed:@"screening_Investors"] title:@"筛选"];
    [self.view addSubview:self.hotProjectTableView];


    // Do any additional setup after loading the view.
}

/**
 *  需继承实现右侧点击事件
 */
- (void)rightBarItemAction:(UITapGestureRecognizer *)gesture{

    if (self.projectScreeningVC) {
        [self.navigationController pushViewController:self.projectScreeningVC animated:true];
    }
    
    
}


-(void)refreshTrade:(NSString*)trade stage:(NSString*)stage{

    self.projectViewModel.trade = trade;
    self.projectViewModel.stage = stage;
    [self.hotProjectTableView.mj_header beginRefreshing];
}

- (void)refresh{

    self.projectViewModel.willLoadMore = NO;
    [self.hotProjectTableView.mj_footer resetNoMoreData];
    [self requestSignal_hotProject];
}

- (void)refreshMore{
    if (!self.projectViewModel.canLoadMore) {
        [self.hotProjectTableView.mj_footer setState:MJRefreshStateNoMoreData];
        return;
    }
    self.projectViewModel.willLoadMore = YES;
    [self requestSignal_hotProject];
}

// 发起请求
- (void)requestSignal_hotProject {


    [self.projectViewModel.requestSignal_allInvestors subscribeNext:^(id x) {

        // 结束刷新状态
        if (self.projectViewModel.willLoadMore) {
            [self.hotProjectTableView.mj_footer endRefreshing];
        }else{
            [self.hotProjectTableView.mj_header endRefreshing];
        }

        // 请求完成后，更新UI

        [self.hotProjectTableView reloadData];

    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _projectViewModel.list.count;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    TRZXInvestorsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TRZXInvestorsCell];
    if (!cell) {
        cell = [[TRZXInvestorsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier_TRZXInvestorsCell];
    }

    TRZXInvestors *model = [_projectViewModel.list objectAtIndex:indexPath.row];
    cell.model = model;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TRZXInvestors *model = [_projectViewModel.list objectAtIndex:indexPath.row];

    UIViewController *projectDetailVC = [[CTMediator sharedInstance] investorDetailViewController:model.mid];
    [self.navigationController pushViewController:projectDetailVC animated:true];


}


-(UITableView *)hotProjectTableView{
    if (!_hotProjectTableView) {
        // 内容视图
        _hotProjectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _hotProjectTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        _hotProjectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _hotProjectTableView.dataSource = self;
        _hotProjectTableView.delegate = self;
        _hotProjectTableView.estimatedRowHeight = 103;  //  随便设个不那么离谱的值
        _hotProjectTableView.rowHeight = UITableViewAutomaticDimension;
        // 去除顶部空白
        _hotProjectTableView.tableHeaderView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];;
        _hotProjectTableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];;
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        _hotProjectTableView.mj_header = [TRZXGifHeader headerWithRefreshingBlock:^{
            // 刷新数据
            [self refresh];
        }];
        [ self.hotProjectTableView.mj_header beginRefreshing];

        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
        _hotProjectTableView.mj_footer = [TRZXGifFooter footerWithRefreshingBlock:^{
            [self refreshMore];

        }];
        _hotProjectTableView.mj_footer.automaticallyHidden = YES;



    }
    return _hotProjectTableView;
}
- (TRZXInvestorsViewModel *)projectViewModel {

    if (!_projectViewModel) {
        _projectViewModel = [TRZXInvestorsViewModel new];
    }
    return _projectViewModel;
}

-(UIViewController *)projectScreeningVC{
    if (!_projectScreeningVC) {
        _projectScreeningVC = [[CTMediator sharedInstance] projectScreeningViewControllerWithScreeningType:@"1" projectTitle:@"投资人筛选" confirmComplete:^(NSString *trade, NSString *stage) {
                [self refreshTrade:trade stage:stage];
        }];
    }
    return _projectScreeningVC;
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
