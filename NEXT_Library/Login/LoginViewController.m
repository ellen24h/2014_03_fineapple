//
//  ViewController.m
//  nextLibrary
//
//  Created by Ducky on 2014. 11. 25..
//  Copyright (c) 2014년 DuckyCho. All rights reserved.
//

#import "loginViewController.h"


@implementation LoginViewController
//viewDidLoad
//  1. status, textfield 설정 초기화
//  2. userDefault로부터 session 값 가져오기
//      2-1.if, session 값이 있으면 veryFirstConnect 진행
//      2-2.else, login 화면 띄우기
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    @autoreleasepool {
    [self initialize];
    NSString * session = [self getSessionFromUserDefault];
    if(session != NULL){
        NSLog(@"%@",session);
        [self veryFirstConnect:session];
    }
    }
 }

//initialize
//  loginViewController class variable들 초기화
//  request, recvData alloc
//  textField 설정 및 status 값들 init
- (void)initialize {
    request = [[NSMutableURLRequest alloc]init];
    recvData = [[NSMutableData alloc] init];
    _emailField.textAlignment = NSTextAlignmentCenter;
    _emailField.font = [UIFont systemFontOfSize:17];
    [_emailField setReturnKeyType:UIReturnKeyDone];
    _passwordField.textAlignment = NSTextAlignmentCenter;
    _passwordField.font = [UIFont systemFontOfSize:17];
    [_passwordField setReturnKeyType:UIReturnKeyDone];
    isViewPosUp = NO;
    curFocusField = -1;
}

//getSessionFromUserDefault
//  userDefault로부터 key값 session에 해당하는 value 가져와서 return
- (NSString *)getSessionFromUserDefault{
    NSUserDefaults * pref = [NSUserDefaults standardUserDefaults];
    NSString * session = [pref stringForKey:@"session"];
    return session;
}
//verFirstConnect
//  userDefault에 session값이 있으면 server에 접속해서 현재 사용자에게 보여줘야 할 화면 세팅
- (void) veryFirstConnect:(NSString *)session{
    NSLog(@"session : %@",session);

    NSURL * url = [NSURL URLWithString:@"http://127.0.0.1:5009/veryFirstConnect"];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"Cookie" forHTTPHeaderField:session];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(connection)
        NSLog(@"connection success");
    else
        NSLog(@"connection fail");
}

//textFieldTouchCancel
// Done버튼을 눌렀을 경우 전체 frame yPos내리고 isViewPosUp 값 변경
- (IBAction)textFieldTouchCancel:(id)sender {
    BOOL down = NO;
    UITextField * tmp = sender;
    tmp.backgroundColor = [UIColor clearColor];
    [self.view endEditing:TRUE];
    if(isViewPosUp == YES){
        isViewPosUp = NO;
        [self moveScreen:down];
    }
}
//textFieldTouchDown
//  textField터치 했을 때, 터치된 textfield 색 변경
- (IBAction)textFieldTouchDown:(id)sender {
    BOOL up = YES;
    UITextField * tmp = sender;
    tmp.backgroundColor = [UIColor whiteColor];
    [self setCurFocusField:sender];
    if(curFocusField == 0){
        _passwordField.backgroundColor = [UIColor clearColor];
    }
    else if(curFocusField ==1){
        _emailField.backgroundColor = [UIColor clearColor];
    }
    if(isViewPosUp == NO){
        isViewPosUp = YES;
        [self moveScreen:up];
    }
}
//setCurFocusField
//  현재 focus되어 있는 textfield에 해당하는 값을 curFocusField에 저장
-(int)setCurFocusField:(NSObject *)obj{
    int ret;
    if(obj == _emailField){
        curFocusField = 0;
        ret = 0;
    }
    else if(obj == _passwordField){
        curFocusField = 1;
        ret = 1;
    }
    else{
        ret = -1;
    }
    return ret;
}
//touchesBegan
//  textfield 편집하다가 화면의 다른부분 눌렀을 경우 키보드를 내리고 화면을 내린다.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(isViewPosUp == YES){
        [self moveScreen:SCREEN_DOWN];
        _passwordField.backgroundColor = [UIColor clearColor];
        _emailField.backgroundColor = [UIColor clearColor];
        [self.view endEditing:YES];
        isViewPosUp = NO;
        curFocusField = -1;
    }
}
//moveScreen
//  Bool값을 받아서 화면을 내리거나 올린다.
//  up : NO, down : YES
- (void)moveScreen:(BOOL)upOrDown{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.view.frame;
    if(upOrDown){
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else{
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}
//Signintouch
//  Signin버튼을 눌렀을때, authenticate 함수를 이용하여 server에 쿼리
//  textfield 값이 비어 있을 때만, server에 쿼리
- (IBAction)signinTouch:(id)sender {
    NSString * email;
    NSString * password;
    
    if( [_emailField.text isEqualToString:@""] != YES &&
       [_passwordField.text isEqualToString:@""] != YES ){
        _comment.text =@"";
        email = [[NSString alloc]initWithString:_emailField.text];
        password = [[NSString alloc]initWithString:_passwordField.text];
        password = [self sha1:password];
        [self authenticate:email password:password];
    }
    else{
        [self setLoginComment:LOGIN_FAIL color:UIColorFromRGB(0xEF4089)];
    }
}

//authenticate
//  서버에 사용자 이메일과 비밀번호를 post data로 전송
//  비밀번호의 경우 sha1함수로 encrypt하여 전송
- (BOOL)authenticate:(NSString *)email password:(NSString *)password{
    @autoreleasepool {
        
        NSString * userData = [[NSString alloc] initWithFormat:@"email=%@&password=%@",email,password];
        NSData * postData = [userData dataUsingEncoding:NSUTF8StringEncoding];
        NSString * dataLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        NSURL * url = [NSURL URLWithString:@"http://127.0.0.1:5009/login"];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:dataLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        if(connection){
            recvData = [[NSMutableData alloc] init];
            NSLog(@"connection success");
            return YES;
        }
        else{
            NSLog(@"connection fail");
            return NO;
        }
    }
}
//sha1
//  input NSString을 sha1 방식으로 encrypt
-(NSString*) sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

//connection : didReceiveResponse
//  서버로부터 response를 받았을 때
//  userDefault에 session 값을 저장
-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"response from Server : %@",response);

    NSUserDefaults * pref;
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)response;
    NSDictionary * dictionary;
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        dictionary = [httpResponse allHeaderFields];
    }
    NSArray * keys = [dictionary allKeys];
    if([keys containsObject:@"Set-Cookie"] == YES){
        NSLog([dictionary valueForKey:@"Set-Cookie"]);
        [pref setObject:[dictionary valueForKey:@"Set-Cookie"] forKey : @"session"];
        [pref synchronize];
    }
}

//connection : didReceiveData
//  server로부터 data 수신을 완료했을때, data의 값을 가지고 사용자가 봐야할 화면으로 화면전환
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [recvData appendData:data];
    NSString * recvData_str =[[NSString alloc]initWithData:recvData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",recvData_str);
    
    if([recvData_str compare:@"NO"] == 0){
        NSLog(@"%@",LOGIN_FAIL);
        [self setLoginComment:LOGIN_FAIL color:UIColorFromRGB(0xEF4089)];
    }
    else if([recvData_str compare:@"YES"] == 0){
        NSLog(@"%@",LOGIN_SUCCESS);
        [self setLoginComment:LOGIN_SUCCESS color:UIColorFromRGB(0x19BDC4)];
    }
    else if([recvData_str compare:@"setProfile"] == 0){
        NSLog(@"%@",LOGIN_SUCCESS);
        [self setLoginComment:@"setProfile" color:UIColorFromRGB(0x19BDC4)];
    }
    else if([recvData_str compare:@"setBookFirst"] == 0){
        NSLog(@"%@",LOGIN_SUCCESS);
        [self setLoginComment:@"setBookFirst" color:UIColorFromRGB(0x19BDC4)];
    }
    else if([recvData_str compare:@"recommend"] == 0){
        NSLog(@"%@",LOGIN_SUCCESS);
        [self setLoginComment:@"recommend" color:UIColorFromRGB(0x19BDC4)];
    }
}
//setLoginComment
//  로그인 성공, 실패시 comment label에 해당하는 text 보여줌
-(void) setLoginComment:(NSString *)comment color:(UIColor *)commentColor{
    _comment.textColor = commentColor;
    _comment.text = comment;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
