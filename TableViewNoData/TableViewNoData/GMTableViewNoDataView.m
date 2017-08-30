//
//  GMTableViewNoDataView.m
//  YYQ
//
//  Created by Z on 2017/7/25.
//  Copyright © 2017年 Z. All rights reserved.
//


//7.设置圆角和边框********************************************************************************************//
#define GM_BorderRadius(Controls, Radius, Width, Color)\
\
[Controls.layer setCornerRadius:(Radius)];\
[Controls.layer setMasksToBounds:YES];\
[Controls.layer setBorderWidth:(Width)];\
[Controls.layer setBorderColor:[Color CGColor]]


//设置字体大小
#define FONTSIZE(x)  [UIFont systemFontOfSize:x]

#import "GMTableViewNoDataView.h"
#import "UIView+GMCategory.h"

@interface GMTableViewNoDataView ()
@property (nonatomic,copy) void (^clickBlock)();
@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UIImage * img;
@property (nonatomic,strong) UIButton * refreshBtn;
@end


@implementation GMTableViewNoDataView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)img viewClick:(void(^)())clickBlock {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.clickBlock = clickBlock;
        self.img = img;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    UIImageView * imgView = [[UIImageView alloc] initWithImage:self.img];
    
    [self addSubview:imgView];
    self.imgView = imgView;
    
    UIButton * refreshBtn = [[UIButton alloc] init];
    self.refreshBtn = refreshBtn;
    GM_BorderRadius(refreshBtn, 8, 0.5, [UIColor redColor]);
    refreshBtn.titleLabel.font = FONTSIZE(12);
    [refreshBtn setTitle:@"点击刷新数据" forState:0];
    [refreshBtn setTitleColor:[UIColor redColor] forState:0];
    [refreshBtn addTarget:self action:@selector(refreshBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:refreshBtn];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImgView:)];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:tap];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgView.center = CGPointMake(self.center.x, self.center.y - 80);
    self.refreshBtn.frame = CGRectMake(20, CGRectGetMaxY(self.imgView.frame), 120, 30);
    self.refreshBtn.centerX = self.imgView.centerX;
    
}

- (void)clickImgView:(UITapGestureRecognizer *)recognizer {
    self.clickBlock();
}

- (void)refreshBtn:(UIButton *)sender {
    
    self.clickBlock();
}

@end
