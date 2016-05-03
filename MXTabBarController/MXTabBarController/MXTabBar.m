//
//  MXTabBar.m
//  MXTabBarController
//
//  Created by Apple on 16/5/3.
//  Copyright © 2016年 韦纯航. All rights reserved.
//

#import "MXTabBar.h"

/**
 *  tabBar上自带按钮个数，不包含加上去的中间按钮，可根据实际需要修改
 */
static const NSInteger MXTabBarItemCount = 4;

@interface MXTabBar ()

@property (retain, nonatomic) MXTabBarCenterButton *centerButton;

@end

@implementation MXTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.centerButton = [MXTabBarCenterButton centerButton];
        [self.centerButton addTarget:self action:@selector(tabBar_centerButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.centerButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (CGRectEqualToRect(self.bounds, CGRectZero)) {
        return;
    }
    
    CGFloat barWidth = CGRectGetWidth(self.bounds);
    CGFloat barHeight = CGRectGetHeight(self.bounds);
    
    /**
     *  在这里可以根据实际需要调整tabBar上个各个按钮的位置
     */
    CGRect centerButtonRect = CGRectZero;
    centerButtonRect.size.height = barHeight - 10.0;
    centerButtonRect.size.width = centerButtonRect.size.height;
    [self.centerButton setFrame:centerButtonRect];
    [self.centerButton setCenter:(CGPoint){barWidth * 0.5, barHeight * 0.5}];
    
    CGFloat itemWidth = barWidth / (MXTabBarItemCount + 1);
    NSInteger itemIndex = 0;
    
    for (UIView *subview in self.subviews) {
        NSString *subviewClass = NSStringFromClass([subview class]);
        if (![subviewClass isEqualToString:@"UITabBarButton"]) {
            continue;
        }
        
        CGFloat itemX = itemIndex * itemWidth;
        if (itemIndex >= 2) itemX += itemWidth; //右边的两个按钮

        CGRect itemRect = subview.frame;
        itemRect.origin.x = itemX;
        itemRect.size.width = itemWidth;
        [subview setFrame:itemRect];
        itemIndex ++;
    }
    
    /**
     *  中间按钮置顶，防止被其他空间挡住
     */
    [self bringSubviewToFront:self.centerButton];
}

/**
 *  中间按钮点击响应事件
 *
 *  @param button 中间按钮
 */
- (void)tabBar_centerButtonEvent:(MXTabBarCenterButton *)button
{
    if (self.mxDelegate && [self.mxDelegate respondsToSelector:@selector(tabBar:didSelectCenterButtonItem:)]) {
        [self.mxDelegate tabBar:self didSelectCenterButtonItem:button];
    }
}

@end
