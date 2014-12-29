//
//  SettingModifyNameViewController.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "SettingModifyNameViewController.h"

@implementation SettingModifyNameViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewDidLoad{
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(FINE_BEIGE);
    model = [SettingModel sharedPostingModel];
    
}
- (IBAction)okButtonTouched:(id)sender {
    [publicSetting setLoadingAnimation:self];
    [model modifyName:_textfield.text];
    [publicSetting removeLoadingAnimation:self];
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
