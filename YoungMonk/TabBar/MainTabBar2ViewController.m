//
//  MainTabBar2ViewController.m
//  TRZX
//
//  Created by 张江威 on 2017/1/23.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "MainTabBar2ViewController.h"
#import "TRZXKit.h"
#import "TRZXCertificationViewController.h"

@interface MainTabBar2ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) NSArray *dataSource;
- (IBAction)nextAction:(id)sender;

@property(nonatomic,strong)UITableView* mytableView;
@property(nonatomic,strong)NSArray *mydataSource;

@end

@implementation MainTabBar2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mydataSource = @[@"提示1",@"提示2",@"提示3"];


    [self.view addSubview:self.mytableView];


    // Do any additional setup after loading the view.
}

- (IBAction)nextAction:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.mydataSource[3] message:@"我崩溃啦 快修复我" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
    NSLog(@"%@",self.mydataSource[3]);
    
    
}



#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* i=  @"cell";
    UITableViewCell* cell = [tableView  dequeueReusableCellWithIdentifier:i];
    if (cell == nil ) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:i];
    }
    //我在这里给cell的标题是"我是修复崩溃前的",通过JS修改成了"我是修复崩溃后的"
    cell.textLabel.text = @"我是修复崩溃前的";
    //我在这里给cell的背景颜色是白色，但是上线后发现红色更好看，我就在JS里写了红色。
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.dataSource = @[@"1",@"2"];
//    // cell有三行，当我点击第三行的时候肯定会数组越界导致 crash
//    //  还好我在JS里弥补了这个bug，详情请看JS里的处理
//    NSString *content = self.dataSource[indexPath.row];
//    NSLog(@"content = %@",content);
    TRZXCertificationViewController *viewController = [[TRZXCertificationViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:true];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(UITableView *)mytableView{
    if (!_mytableView) {
        // 内容视图
        _mytableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mytableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mytableView.dataSource = self;
        _mytableView.delegate = self;

    }
    return _mytableView;
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
