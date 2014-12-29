//
//  SettingModifyPasswordViewController.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "SettingModifyPasswordViewController.h"

@implementation SettingModifyPasswordViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewDidLoad{
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(FINE_BEIGE);
}
- (IBAction)okButtonTouched:(id)sender {
    NSString * first = _textField_first.text;
    NSString * second = _textField_second.text;
    NSString * password;
    if([first isEqualToString:second] == YES){
        SettingModel * model = [SettingModel sharedPostingModel];
        password = [publicSetting sha1:first];
        [publicSetting setLoadingAnimation:self];
        [model modifyPassword:password];
        [publicSetting removeLoadingAnimation:self];
        [[self navigationController] popViewControllerAnimated:YES];
    }
    else{
        _warningLabel.text = @"비밀번호가 달라요. 다시 입력해주세요.";
    }
}

@end
