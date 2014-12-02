//
//  RegisterEmailViewController.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 2..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "RegisterEmailViewController.h"

@interface RegisterEmailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *checkpassword;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *errormethod;
@end

@implementation RegisterEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.emailField.text = @"";
    //self.passwordField.text = @"";
    //self.checkpassword.text = @"";
    //self.nameField.text = @""; // 굳이 초기화 작업이 진행될 필요는 없을 것 같음.
    // Do any additional setup after loading the view.
    //UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector];
    //[self.view addGestureRecognizer:tap];
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
    self.emailField.text = @"";
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
    
    if (![self checkEmail:email]) {
        self.errormethod.text = @"이미 존재하는 이메일입니다.";
        self.errormethod.textColor = [UIColor redColor];
        self.emailField.textColor = [UIColor redColor];
    }
    [self.view endEditing:YES];
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
    [self.view endEditing:YES];
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
    [self.view endEditing:YES];
}

//이름 입력 시작
- (IBAction)nameBegin:(UITextField *)sender {
    self.nameField.text = @"";
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
    [self.view endEditing:YES];
}

//확인 버튼을 누름
- (IBAction)success:(UIButton *)sender {
    NSString * email = [self.emailField text];
    NSString * password = [self.passwordField text];
    NSString * name = [self.nameField text];
    
    if ([self checkSuccess]) {
        //NSURLRequest 만들기
        NSString * URLString = @"http://10.73.45.55:5000/register";
        NSString * FormData = [NSString stringWithFormat:@"email=%@&password=%@&userName=%@",email,password,name];
        NSURL * url = [NSURL URLWithString:URLString];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[FormData dataUsingEncoding:NSUTF8StringEncoding]];
        
        //NSURLConnection 으로 Request 전송
        NSHTTPURLResponse * sResponse;
        NSError * error;
        NSData * resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&sResponse error:&error];
        NSLog(@"response = %ld", (long)sResponse.statusCode);
        NSLog(@"result = %@", [NSString stringWithUTF8String:resultData.bytes] );
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

- (BOOL)checkEmail:(NSString *) email {
    NSString * URLString = @"http://10.73.45.55:5000/register/email";
    NSString * FormData = [NSString stringWithFormat:@"email=%@",email];
    NSURL * url = [NSURL URLWithString:URLString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[FormData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSHTTPURLResponse * response;
    NSError * error;
    NSData * resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString * result = [NSString stringWithUTF8String:resultData.bytes];
    
    NSLog(@"response = %ld", (long)response.statusCode);
    NSLog(@"result = %@", result);
    
    if ([result  isEqual: @"None"]){
        return YES;
    } else return NO;
}


@end
