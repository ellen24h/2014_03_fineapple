//
//  RegisterEmailViewController.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 2..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "RegisterEmailViewController.h"

@interface RegisterEmailViewController ()
{
    RegisterModel * model;
}

@end

@implementation RegisterEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [[RegisterModel alloc] initWithURLwithPort:[publicSetting getServerAddr] port:[publicSetting getPortNum]];
    textField_Check_email = NO;
    textField_Check_name = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)didTap:(UITapGestureRecognizer*)tap {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//이메일 입력 시작
- (IBAction)EmailBegin:(UITextField *)sender {
    if (textField_Check_email == NO) {
        self.emailField.text = @"";
        self.emailField.textColor = [UIColor blackColor];
    }
    self.emailField.textColor = [UIColor blackColor];
}

//이메일 입력 확인
- (IBAction)EmailEnd:(UITextField *)sender {
    NSString *email = [self.emailField text];
    
    if([email isEqualToString:@""]){
        self.errormethod.text = @"이메일 주소를 입력해 주세요.";
        self.errormethod.textColor = [UIColor redColor];
        return;
    };
    
    if(![self NSStringIsValidEmail:email]){
        self.errormethod.text = @"메일주소의 형식이 맞지 않습니다.";
        self.errormethod.textColor = [UIColor redColor];
        self.emailField.textColor = [UIColor redColor];
        return;
    }
    
    if (![model checkEmail:email]) {
        self.errormethod.text = @"이미 존재하는 이메일입니다.";
        self.errormethod.textColor = [UIColor redColor];
        self.emailField.textColor = [UIColor redColor];
    }
    textField_Check_name = YES;
}

//비밀번호 입력 시작
- (IBAction)passwordBegin:(UITextField *)sender {
    self.passwordField.text = @"";
    self.passwordField.textColor = [UIColor blackColor];
    self.passwordField.secureTextEntry = TRUE; //secureTextEntry 활성화
}

//비밀번호 입력 확인
- (IBAction)passwordEnd:(UITextField *)sender {
    NSString *pw = [self.passwordField text];
    
    if([pw isEqualToString:@""]){
        self.errormethod.text = @"비밀번호를 입력해 주세요.";
        self.errormethod.textColor = [UIColor redColor];
        return;
    }
}

//비밀번호 확인 입력 시작
- (IBAction)checkPwBegin:(UITextField *)sender {
    self.checkpassword.text = @"";
    self.checkpassword.textColor = [UIColor blackColor];
    self.checkpassword.secureTextEntry = TRUE; //secureTextEntry 활성화
}

//비밀번호 확인 입력 확인
- (IBAction)checkPwEnd:(UITextField *)sender {
    NSString *pw = [self.passwordField text];
    NSString *pwAgain = [self.checkpassword text];
    
    if([pwAgain isEqualToString:@""]){
        self.errormethod.text = @"비밀번호 재확인을 입력해 주세요.";
        self.errormethod.textColor = [UIColor redColor];
        self.checkpassword.textColor = [UIColor redColor];
        return;
    };
    
    if(![pw isEqualToString:pwAgain]){
        self.errormethod.text = @"비밀번호가 다릅니다.";
        self.errormethod.textColor = [UIColor redColor];
        self.checkpassword.textColor = [UIColor redColor];
        return;
    }
}

//이름 입력 시작
- (IBAction)nameBegin:(UITextField *)sender {
    if (textField_Check_name == NO){
        self.nameField.text = @"";
        self.nameField.textColor = [UIColor blackColor];
    }
    self.nameField.textColor = [UIColor blackColor];
}

//이름 입력 확인
- (IBAction)nameEnd:(UITextField *)sender {
    NSString *name = [self.nameField text];
    if([name isEqualToString:@""]){
        self.errormethod.text = @"이름을 입력해 주세요.";
        self.errormethod.textColor = [UIColor redColor];
        return;
    }
    textField_Check_name = YES;
}

//확인 버튼을 누름
- (IBAction)success:(UIButton *)sender {
    NSString * email = [self.emailField text];
    NSString * password = [self.passwordField text];
    NSString * name = [self.nameField text];
    
    if ([self checkSuccess]) {
        [model successConnection:email :password :name];
    }
}

//이메일 형식이 옳은지 확인
-(BOOL) NSStringIsValidEmail:(NSString *)checkString {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(BOOL) checkSuccess {
    NSString *email = [self.emailField text];
    NSString *pwAgain = [self.checkpassword text];
    NSString *pw = [self.passwordField text];
    NSString *name = [self.nameField text];
    
    if([email isEqualToString:@""]){
        self.errormethod.text = @"이메일 주소를 입력해 주세요.";
        self.errormethod.textColor = [UIColor redColor];
        return NO;
    }
    
    if([pw isEqualToString:@""]){
        self.errormethod.text = @"비밀번호를 입력해 주세요.";
        self.errormethod.textColor = [UIColor redColor];
        return NO;
    }
    
    if([pwAgain isEqualToString:@""]){
        self.errormethod.text = @"비밀번호 재확인을 입력해 주세요.";
        self.errormethod.textColor = [UIColor redColor];
        return NO;
    }
    
    
    if([name isEqualToString:@""]){
        self.errormethod.text = @"이름을 입력해 주세요.";
        self.errormethod.textColor = [UIColor redColor];
        return NO;
    }
    
    
    if(![self NSStringIsValidEmail:email]){
        self.errormethod.text = @"메일주소의 형식이 맞지 않습니다.";
        self.errormethod.textColor = [UIColor redColor];
        return NO;
    }
    
    if(![pw isEqualToString:pwAgain]){
        self.errormethod.text = @"비밀번호가 다릅니다.";
        self.errormethod.textColor = [UIColor redColor];
        return NO;
    }
    self.errormethod.textColor = [UIColor blueColor];
    self.errormethod.text = @"완료";
    return YES;
}

// 활동중인 텍스트 필드 설정
-(void)dismissKeyboard
{
    UITextField *activeTextField = nil;
    if ([self.emailField isEditing]) {
        activeTextField = self.emailField;
    }
    else if ([self.passwordField isEditing]) {
        activeTextField = self.passwordField;
    }
    else if ([self.checkpassword isEditing]) {
        activeTextField = self.checkpassword;
    }
    else if ([self.checkpassword isEditing]) {
        activeTextField = self.checkpassword;
    }
    else if ([self.nameField isEditing]) {
        activeTextField = self.nameField;
    }
    if (activeTextField) {
        [activeTextField resignFirstResponder];
    }
}


@end
