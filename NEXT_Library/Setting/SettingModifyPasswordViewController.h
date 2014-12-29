//
//  SettingModifyPasswordViewController.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingModel.h"
#import "publicSetting.h"
@interface SettingModifyPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField_first;
@property (weak, nonatomic) IBOutlet UITextField *textField_second;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

@end
