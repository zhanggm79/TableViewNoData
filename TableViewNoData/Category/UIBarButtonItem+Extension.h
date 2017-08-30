//
//  UIBarButtonItem+Extension.h
//
//  Created by zhang on 15/10/27.
//  Copyright © 2015年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;


+ (instancetype)itemWithImageName:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action ;


+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;


@end
