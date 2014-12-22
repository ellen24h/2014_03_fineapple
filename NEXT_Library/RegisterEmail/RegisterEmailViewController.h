//
//  RegisterEmailViewController.h
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 2..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicSetting.h"
#import "RegisterModel.h"


@interface RegisterEmailViewController : UIViewController
{
    BOOL textField_Check_email;
    BOOL textField_Check_name;
}

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *checkpassword;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *errormethod;
@property(nonatomic, readonly, getter=isEditing) BOOL editing;

@end
