//
//  SettingModifyNameViewController.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingModel.h"
#import "publicSetting.h"
@interface SettingModifyNameViewController : UIViewController
{
@private
    SettingModel * model;
}
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
