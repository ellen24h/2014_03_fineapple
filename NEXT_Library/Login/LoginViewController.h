//
//  ViewController.h
//  nextLibrary
//
//  Created by Ducky on 2014. 11. 25..
//  Copyright (c) 2014년 DuckyCho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"
#import "publicSetting.h"

//로그인 성공 혹은 실패시 comment field에 나오는 멘트
#define LOGIN_FAIL @"잘못된 정보를 입력하셨습니다."
#define LOGIN_SUCCESS @"Longin Success!"
//사용자가 email, password field를 터치했을 때
//화면이 올라가고 내려가야하는데 그때 쓰는 상수값
#define SCREEN_UP 1
#define SCREEN_DOWN 0



@interface LoginViewController : UIViewController
{
@public
    BOOL isViewPosUp;
    int curFocusField;
    LoginModel * model;
}


@property (weak, nonatomic) IBOutlet UITextField * emailField;
@property (weak, nonatomic) IBOutlet UITextField * passwordField;
@property (weak, nonatomic) IBOutlet UIButton * singIn;
@property (weak, nonatomic) IBOutlet UIButton * signUp;
@property (weak, nonatomic) IBOutlet UIButton * signInFB;
@property (weak, nonatomic) IBOutlet UILabel *comment;



@end

