//
//  InvestorListTableViewCell.m
//  TRZX
//
//  Created by 移动微 on 16/10/8.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TRZXInvestorsCell.h"
#import "Masonry.h"
#import "UIImageView+AFNetworking.h"
#import "TRZXKit.h"
@interface TRZXInvestorsCell()

@property(nonatomic, strong) UIView *backView;

@property(nonatomic, strong) UIImageView *headImageView;

@property(nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UILabel *positionLabel;

@property(nonatomic, strong) UILabel *companyLabel;

@property(nonatomic, strong) UILabel *domainLabel;

@property(nonatomic, strong) UILabel *stageLabel;

@end


@implementation TRZXInvestorsCell



-(void)setModel:(TRZXInvestors *)model{
    
    if (_model != model) {
        _model = model;

        [self.headImageView setImageWithURL:[NSURL URLWithString:model.head_img]];
        self.nameLabel.text = model.realName;
        
        self.domainLabel.text = [NSString stringWithFormat:@"投资领域: %@",model.focusTradesName?model.focusTradesName:@""];
        self.companyLabel.text = model.organization;
        self.positionLabel.text = model.iposition;
        
        NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"投资阶段: %@",model.investmentStages]];
        
        [attributeText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:NSMakeRange(attributeText.length -  model.investmentStages.length, model.investmentStages.length)];

        self.stageLabel.attributedText = attributeText;
    }
}

#pragma mark - Initialize
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}


#pragma mark - Properties
-(UILabel *)stageLabel{
    if (!_stageLabel) {
        _stageLabel = [[UILabel alloc]init];
        _stageLabel.text = @"";
        _stageLabel.textAlignment = NSTextAlignmentLeft;
        _stageLabel.font = [UIFont systemFontOfSize:12];
        _stageLabel.textColor = [UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1];
        _stageLabel.numberOfLines = 0;
        _stageLabel.clipsToBounds = YES;
        [_stageLabel sizeToFit];
        [self.backView addSubview:_stageLabel];
        [_stageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.domainLabel.mas_bottom).offset(5);
            make.left.equalTo(self.nameLabel);
            make.right.equalTo(self.domainLabel);
        }];
        
        _stageLabel.contentMode = UIViewContentModeScaleAspectFill;
        _stageLabel.clipsToBounds = YES;
        
        UIView * border = [UIView new];
        [self.contentView addSubview:border];
        [border mas_makeConstraints:^(MASConstraintMaker * make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.top.equalTo(self.backView.mas_bottom).offset(0);
            make.height.offset(5);
        }];
    }
    return _stageLabel;
}

-(UILabel *)domainLabel{
    if (!_domainLabel) {
        _domainLabel = [[UILabel alloc]init];
        _domainLabel.text = @"";
        _domainLabel.textAlignment = NSTextAlignmentLeft;
        _domainLabel.font = [UIFont systemFontOfSize:12];
        _domainLabel.textColor = [UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1];
        _domainLabel.numberOfLines = 0;
        _domainLabel.clipsToBounds = YES;
        [_domainLabel sizeToFit];
        [self.backView addSubview:_domainLabel];
        [_domainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.companyLabel.mas_bottom).offset(5);
            make.left.equalTo(self.nameLabel);
            make.right.equalTo(self.backView).offset(-5);
        }];
    }
    return _domainLabel;
}

-(UILabel *)companyLabel{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc]init];
        _companyLabel.text = @"";
        _companyLabel.textAlignment = NSTextAlignmentLeft;
        _companyLabel.font = [UIFont systemFontOfSize:16];
        _companyLabel.textColor = [UIColor trzx_NavTitleColor];
        _companyLabel.numberOfLines = 0;
        _companyLabel.clipsToBounds = YES;
        [_companyLabel sizeToFit];
        [self.backView addSubview:_companyLabel];
        [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
            make.left.equalTo(self.nameLabel);
            make.right.equalTo(self.backView).offset(-5);
        }];
    }
    return _companyLabel;
}

-(UILabel *)positionLabel{
    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc]init];
        _positionLabel.text = @"";
        _positionLabel.textAlignment = NSTextAlignmentLeft;
        _positionLabel.font = [UIFont systemFontOfSize:12];
        _positionLabel.textColor = [UIColor trzx_NavTitleColor];;
        _positionLabel.numberOfLines = 0;
        _positionLabel.clipsToBounds = YES;
        [_positionLabel sizeToFit];
        [self.backView addSubview:_positionLabel];
        [_positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.nameLabel);
            make.left.equalTo(self.nameLabel.mas_right).offset(10);
        }];
    }
    return _positionLabel;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor trzx_NavTitleColor];
        _nameLabel.numberOfLines = 0;
        _nameLabel.clipsToBounds = YES;
        [_nameLabel sizeToFit];
        [self.backView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backView).offset(12);
            make.left.equalTo(self.backView).offset(100);
            make.right.lessThanOrEqualTo(self.backView).offset(-60);
            make.height.greaterThanOrEqualTo(@(17));
        }];
    }
    return _nameLabel;
}

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius =   5;
        _headImageView.layer.masksToBounds = YES;

        [self.backView addSubview:self.headImageView];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backView).offset(15);
            make.left.equalTo(self.backView).offset(15);
            make.height.offset(75);
            make.width.offset(75);
//            make.bottom.equalTo(self.backView).offset(-15);
        }];
    }
    return _headImageView;
}

-(UIView *)backView{
    if (!_backView) {
        _backView =[[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];

        [self.contentView addSubview:_backView];
        _backView.layer.cornerRadius = 6;
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.bottom.equalTo(self.stageLabel).offset(10);
        }];
    }
    return _backView;
}

@end
