//
//  SettingViewController.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    model = [SettingModel sharedPostingModel];
    NSDictionary * userInfo = [model getUserInfo];
    [_nameLabel setText:[userInfo objectForKey:@"userName"]];
    [_emailLabel setText:[userInfo objectForKey:@"userEmail"]];
    [_readCount setText:[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"readCount"]]];
    [_wishCount setText:[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"wishCount"]]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logout:) name:@"logout" object:nil];
}

-(void)viewDidLoad{
   [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)logout:(NSNotification *)noti{
    
}

- (IBAction)logoutButtonTouched:(id)sender {
    [model logout];
}

@end
