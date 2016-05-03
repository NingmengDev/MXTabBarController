//
//  MXTabBar.h
//  MXTabBarController
//
//  Created by Apple on 16/5/3.
//  Copyright © 2016年 韦纯航. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MXTabBarCenterButton.h"

@class MXTabBar;

@protocol MXTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MXTabBar *)tabBar didSelectCenterButtonItem:(MXTabBarCenterButton *)buttonItem;

@end


@interface MXTabBar : UITabBar

@property (assign, nonatomic) id <MXTabBarDelegate> mxDelegate;

@end
