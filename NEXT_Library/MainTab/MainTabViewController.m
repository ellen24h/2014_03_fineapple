//
//  MainTabViewController.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 10..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "MainTabViewController.h"

@implementation MainTabViewController

+ (void)initialize
{
    //the color for the text for unselected tabs
    [UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateNormal];
    
    //the color for selected icon
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        for (UITabBarItem *tbi in self.tabBar.items) {
            tbi.image = [tbi.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }
}
@end