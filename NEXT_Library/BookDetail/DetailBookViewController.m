//
//  DetailBookViewController.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 28..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "DetailBookViewController.h"

@interface DetailBookViewController ()

@end

@implementation DetailBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scroll setScrollEnabled:YES];
    [self.scroll setContentSize:CGSizeMake(320, 1200)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
