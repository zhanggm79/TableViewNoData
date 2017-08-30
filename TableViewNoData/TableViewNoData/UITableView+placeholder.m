//
//  UITableView+placeholder.m
//  YYQ
//
//  Created by Z on 2017/7/25.
//  Copyright © 2017年 Z. All rights reserved.
//

#import "UITableView+placeholder.h"
#import <objc/runtime.h>

@implementation NSObject (swizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSel WithSwizzledSelector:(SEL)swizzledSel {
   Class class = [self class];
    //原有方法
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    //替换原有方法的新方法
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSel);
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class,originalSel,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {//添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class,swizzledSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {//添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end


@implementation UITableView (placeholder)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceSelector:@selector(reloadData) WithSwizzledSelector:@selector(gm_reloadData)];
    });
}

- (void)setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeHolderView {
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}


- (void)gm_reloadData {
    [self gm_checkEmpty];
    [self gm_reloadData];
    
}



- (void)gm_checkEmpty {
    BOOL isEmpty = YES;
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    for (int i = 0; i < sections; i++) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    if (isEmpty) {
        [self.placeHolderView removeFromSuperview];
        [self addSubview:self.placeHolderView];
    }else{
        [self.placeHolderView removeFromSuperview];
    }
    
}



@end
