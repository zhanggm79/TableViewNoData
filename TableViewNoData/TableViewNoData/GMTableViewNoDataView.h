//
//  GMTableViewNoDataView.h
//  YYQ
//
//  Created by Z on 2017/7/25.
//  Copyright © 2017年 Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMTableViewNoDataView : UIView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)img viewClick:(void(^)())clickBlock;

@end
