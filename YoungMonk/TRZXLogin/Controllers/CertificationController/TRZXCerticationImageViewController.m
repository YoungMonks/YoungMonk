//
//  TRZXCerticationImageViewController.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/24.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXCerticationImageViewController.h"

#import "TRZXCertificationImageCell.h"
#import "TRZXCerticationChooseCell.h"
#import "TRZXCertTitleCell.h"
#import "TRZXPushLabelCell.h"

#import "TRZXPositionModel.h"
#import "TRZXRZIformationMode.h"
#import "TRZXLoginLogic.h"

@interface TRZXCerticationImageViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, strong) NSIndexPath *index;
@property (strong, nonatomic) TRZXRZIformationMode * mode;
@property (strong, nonatomic) NSArray * titleArr;
@property (nonatomic, assign) BOOL yesNoStr;
@end

@implementation TRZXCerticationImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    [self.view addSubview:self.tableView];
    _mode = [[TRZXRZIformationMode alloc]init];
    _yesNoStr = YES;
//    [self Position_Api];
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
    return 4;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 10;
    } else if (indexPath.section == 1) {
        return 50;
    } else if (indexPath.section == 2) {
        return 150;
    } else {
        return 80;
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
    } else if (indexPath.section == 1) {
        TRZXCerticationChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXCerticationChooseCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXCerticationChooseCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //设置分段控件点击相应事件
        [cell.segmented addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
        return cell;
    } else if (indexPath.section == 2) {
        TRZXCertificationImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXCertificationImageCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXCertificationImageCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.firstImage.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadClick:)];
        [cell.firstImage addGestureRecognizer:tap1];
        cell.secondImage.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadClick:)];
        [cell.secondImage addGestureRecognizer:tap2];
        cell.thirdImage.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadClick:)];
        [cell.thirdImage addGestureRecognizer:tap3];
        if (_yesNoStr) {
            cell.firstLabel.text = @"身份证正面";
            cell.secondLabel.text = @"身份证反面";
            cell.thirdLabel.hidden = YES;
            cell.thirdImage.hidden = YES;
        }else{
            cell.firstLabel.text = @"身份证正面";
            cell.secondLabel.text = @"身份证反面";
            cell.thirdLabel.text = @"股东身份证明";
            cell.thirdLabel.hidden = NO;
            cell.thirdImage.hidden = NO;
        }
        return cell;
    } else{
        TRZXPushLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXPushLabelCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXPushLabelCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = backColor;
        cell.nextLabel.text = @"提交审核";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}
//点击事件
-(void)doSomethingInSegment:(UISegmentedControl *)Segmented{
    
    switch (Segmented.selectedSegmentIndex)
    {
        case 0:
            _yesNoStr = YES;
            break;
        case 1:
            _yesNoStr = NO;
            break;
        default:
            break;
    }
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
//上传图片事件
- (void)uploadClick:(UITapGestureRecognizer *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册中选择", nil];
    [actionSheet showInView:self.view];
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




