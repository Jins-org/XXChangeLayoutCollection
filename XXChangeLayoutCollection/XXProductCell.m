//
//  XXProductCell.m
//  XXChangeLayoutCollection
//
//  Created by Jins on 2020/6/23.
//  Copyright © 2020 Jins-org. All rights reserved.
//

#import "XXProductCell.h"
#import "Masonry.h"

@interface XXProductCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *brandTagLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *activityLabel1;

@property (nonatomic, strong) UILabel *activityLabel2;

@property (nonatomic, strong) UILabel *activityLabel3;

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation XXProductCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listTypeDidChange:) name:@"ListTypeDidChange" object:nil];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 3.f;
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.brandTagLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.activityLabel1];
    [self.contentView addSubview:self.activityLabel2];
    [self.contentView addSubview:self.activityLabel3];
    [self.contentView addSubview:self.priceLabel];
    
    // 默认为Grid布局
    [self setupConstraintsForGridLayout];
}

- (void)setupConstraintsForGridLayout {
    // 其实不必所有布局都使用remake，这里全部使用remake只是因为懒。。
    // 适当使用update可以节省不必要的资源浪费
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(150);
    }];
    
    [self.brandTagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageView.mas_bottom);
        make.left.offset(15);
    }];
 
    self.nameLabel.numberOfLines = 2;
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.brandTagLabel.mas_bottom).offset(5);
        make.left.equalTo(self.brandTagLabel);
        make.right.offset(-15);
    }];
    
    [self.activityLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(self.nameLabel);
    }];
    
    [self.activityLabel2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.activityLabel1);
        make.left.equalTo(self.activityLabel1.mas_right).offset(5);
    }];
    
    [self.activityLabel3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.activityLabel2);
        make.left.equalTo(self.activityLabel2.mas_right).offset(5);
    }];
    
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.activityLabel1.mas_bottom).offset(5);
        make.left.equalTo(self.brandTagLabel);
    }];
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.contentView layoutIfNeeded];
    }];
}

- (void)setupConstraintsForListLayout {
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.offset(0);
        make.width.mas_equalTo(150);
    }];
    
    [self.brandTagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(10);
        make.top.offset(20);
    }];
    
    [self.activityLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.brandTagLabel.mas_bottom).offset(8);
        make.left.equalTo(self.brandTagLabel);
    }];
    
    [self.activityLabel2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.activityLabel1);
        make.left.equalTo(self.activityLabel1.mas_right).offset(5);
    }];
    
    [self.activityLabel3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.activityLabel2);
        make.left.equalTo(self.activityLabel2.mas_right).offset(5);
    }];
        
    self.nameLabel.numberOfLines = 3;
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.activityLabel1.mas_bottom).offset(8);
        make.left.equalTo(self.imageView.mas_right).offset(10);
        make.right.offset(-15);
    }];
    
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(self.nameLabel);
    }];
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.contentView layoutIfNeeded];
    }];
}

- (void)listTypeDidChange:(NSNotification *)noti {
    self.isList = [noti.object boolValue];
}

#pragma mark - Setters

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
}

- (void)setIsList:(BOOL)isList {
    _isList = isList;
    if (_isList) {
        [self setupConstraintsForListLayout];
    } else {
        [self setupConstraintsForGridLayout];
    }
}

#pragma mark - Getters

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
 
- (UILabel *)brandTagLabel {
    if (!_brandTagLabel) {
        _brandTagLabel = [[UILabel alloc] init];
        _brandTagLabel.font = [UIFont systemFontOfSize:11];
        _brandTagLabel.textColor = UIColor.redColor;
        _brandTagLabel.layer.cornerRadius = 1.f;
        _brandTagLabel.layer.borderColor = [UIColor.redColor CGColor];
        _brandTagLabel.layer.borderWidth = 0.5f;
        _brandTagLabel.text = @"品牌标签";
    }
    return _brandTagLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 2;
        _nameLabel.textColor = UIColor.blackColor;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.text = @"商品名商品名商品名商品名商品名商品名商品名商品名商品名商品名商品名商品名商品名商品名商品名";
    }
    return _nameLabel;
}

- (UILabel *)activityLabel1 {
    if (!_activityLabel1) {
        _activityLabel1 = [[UILabel alloc] init];
        _activityLabel1.font = [UIFont systemFontOfSize:11];
        _activityLabel1.textColor = UIColor.redColor;
        _activityLabel1.layer.cornerRadius = 1.f;
        _activityLabel1.layer.borderColor = [UIColor.redColor CGColor];
        _activityLabel1.layer.borderWidth = 0.5f;
        _activityLabel1.text = @"限时秒杀";
    }
    return _activityLabel1;
}

- (UILabel *)activityLabel2 {
    if (!_activityLabel2) {
        _activityLabel2 = [[UILabel alloc] init];
        _activityLabel2.font = [UIFont systemFontOfSize:11];
        _activityLabel2.textColor = UIColor.blueColor;
        _activityLabel2.layer.cornerRadius = 1.f;
        _activityLabel2.layer.borderColor = [UIColor.blueColor CGColor];
        _activityLabel2.layer.borderWidth = 0.5f;
        _activityLabel2.text = @"预计明日送达";
    }
    return _activityLabel2;
}

- (UILabel *)activityLabel3 {
    if (!_activityLabel3) {
        _activityLabel3 = [[UILabel alloc] init];
        _activityLabel3.font = [UIFont systemFontOfSize:11];
        _activityLabel3.textColor = UIColor.redColor;
        _activityLabel3.layer.cornerRadius = 1.f;
        _activityLabel3.layer.borderColor = [UIColor.redColor CGColor];
        _activityLabel3.layer.borderWidth = 0.5f;
        _activityLabel3.text = @"0元购";
    }
    return _activityLabel3;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:16];
        _priceLabel.textColor = UIColor.redColor;
        _priceLabel.text = @"¥5499";
    }
    return _priceLabel;
}

@end
