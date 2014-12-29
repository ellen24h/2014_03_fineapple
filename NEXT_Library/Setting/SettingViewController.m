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
    SettingModel * model = [SettingModel sharedPostingModel];
    NSDictionary * userInfo = [model getUserInfo];
    [_nameLabel setText:[userInfo objectForKey:@"userName"]];
    [_emailLabel setText:[userInfo objectForKey:@"userEmail"]];
    [_readCount setText:[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"readCount"]]];
    [_wishCount setText:[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"wishCount"]]];
}

- (void)viewDidLoad{
   
}


@end
