//
//  MXTabBarController.m
//  MXTabBarController
//
//  Created by Apple on 16/5/3.
//  Copyright © 2016年 韦纯航. All rights reserved.
//

#import "MXTabBarController.h"

#import "MXTabBar.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

#define MXTabBarColorFromHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

@interface MXTabBarController () <MXTabBarDelegate>

@end

@implementation MXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpTabBarItemTextAttributes];
    
    [self setUpChildViewController];
    
    [self setUpTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes
{
    NSDictionary *itemTitleTextAttributesNormal = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0], NSFontAttributeName, MXTabBarColorFromHexRGB(0x7a7e83), NSForegroundColorAttributeName, nil];
    NSDictionary *itemTitleTextAttributesSelected = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0], NSFontAttributeName, MXTabBarColorFromHexRGB(0x1db0ed), NSForegroundColorAttributeName, nil];
    [[UITabBarItem appearance] setTitleTextAttributes:itemTitleTextAttributesNormal forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:itemTitleTextAttributesSelected forState:UIControlStateSelected];
}

/**
 *  添加子控制器
 */
- (void)setUpChildViewController
{
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    FourthViewController *fourthViewController = [[FourthViewController alloc] init];
    
    firstViewController.title = @"FirstViewController";
    secondViewController.title = @"SecondViewController";
    thirdViewController.title = @"ThirdViewController";
    fourthViewController.title = @"FourthViewController";
    
    UINavigationController *nav0 = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:thirdViewController];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:fourthViewController];
    
    [self addChildViewController:nav0 title:@"First" normalImage:@"Tabbar_First.png" selectedImage:@"Tabbar_FirstHL.png"];
    [self addChildViewController:nav1 title:@"Second" normalImage:@"Tabbar_Second.png" selectedImage:@"Tabbar_SecondHL.png"];
    [self addChildViewController:nav2 title:@"Third" normalImage:@"Tabbar_Third.png" selectedImage:@"Tabbar_ThirdHL.png"];
    [self addChildViewController:nav3 title:@"Fourth" normalImage:@"Tabbar_Fourth.png" selectedImage:@"Tabbar_FourthHL.png"];
}

/**
 *  利用 KVC 把系统的tabBar类型改为自定义类型
 */
- (void)setUpTabBar
{
    if ([self respondsToSelector:NSSelectorFromString(@"tabBar")]) {
        MXTabBar *tabBar = [MXTabBar new];
        [tabBar setMxDelegate:self];
        [self setValue:tabBar forKey:@"tabBar"];
    }
}

/**
 *  添加一个子控制器
 *
 *  @param viewController 控制器
 *  @param title          标题
 *  @param imageNormal    默认Item图片
 *  @param imageSelected  选中Item图片
 */
- (void)addChildViewController:(UIViewController *)viewController
                         title:(NSString *)title
                   normalImage:(NSString *)imageNormal
                 selectedImage:(NSString *)imageSelected
{
    
    viewController.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [[UIImage imageNamed:imageNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    viewController.tabBarItem.title = title;
    
    [self addChildViewController:viewController];
}

#pragma mark - MXTabBarDelegate

- (void)tabBar:(MXTabBar *)tabBar didSelectCenterButtonItem:(MXTabBarCenterButton *)buttonItem
{
    /* 在这里可以加上自己的处理代码 */
    // ......
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"点击了中间的按钮" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
