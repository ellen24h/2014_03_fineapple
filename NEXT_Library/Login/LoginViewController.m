//
//  ViewController.m
//  nextLibrary
//
//  Created by Ducky on 2014. 11. 25..
//  Copyright (c) 2014년 DuckyCho. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController
//viewDidLoad
//  1. model객체를 생성하고 노티센터에 didSceneNameReceived라는 노티를 받는 옵져버로 등록
//  2.
- (void)viewDidLoad {
    [super viewDidLoad];

    @autoreleasepool {
        model = [[LoginModel alloc]initWithURLwithPort:[publicSetting getServerAddr] port:[publicSetting getPortNum]];
        NSNotificationCenter * notiCenter = [NSNotificationCenter defaultCenter];
        NSString * firstScene;
        [notiCenter addObserver:self selector:@selector(loadScene:) name:@"didSceneNameReceived" object:nil];
        firstScene = [model getFirstSceneNameFromServer];
        [self viewInitialize];
        [publicSetting setLoadingAnimation:self];
        if ([firstScene isEqualToString:@"Login"] == YES){
            [publicSetting removeLoadingAnimation:self];
        }
    }
 }

//viewInitialize
//  loginViewController class variable들 초기화
//  request, recvData alloc
//  textField 설정 및 status 값들 init
- (void)viewInitialize {
    _emailField.textAlignment = NSTextAlignmentCenter;
    _emailField.font = [UIFont systemFontOfSize:17];
    [_emailField setReturnKeyType:UIReturnKeyDone];
    
    _passwordField.textAlignment = NSTextAlignmentCenter;
    _passwordField.font = [UIFont systemFontOfSize:17];
    [_passwordField setReturnKeyType:UIReturnKeyDone];
    
    isViewPosUp = NO;
    curFocusField = -1;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"navShadow.png"];
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
//  up : YES, down : NO
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
//  Signin버튼을 눌렀을때, model에 textfield에 있는 값들 넘겨줌
//  model객체내의  signIn함수를 통해 다음에 보여줄 화면이름을 받아옴
- (IBAction)signinTouch:(id)sender {
    if( [_emailField.text isEqualToString:@""] != YES && [_passwordField.text isEqualToString:@""] != YES ){
        [publicSetting setLoadingAnimation:self];
        [model signIn:_emailField.text password:_passwordField.text];
    }
    else
        [self setLoginComment:LOGIN_FAIL color:UIColorFromRGB(0xEF4089)];
}

//setLoginComment
//  로그인 성공, 실패시 comment label에 해당하는 text 보여줌
-(void)setLoginComment:(NSString *)comment color:(UIColor *)commentColor{
    _comment.textColor = commentColor;
    _comment.text = comment;
}

//loadScene
//  서버로부터 사용자에게 보여줄 화면이름을 return받아서
//  다음 화면을 push하는 함수
- (void)loadScene:(NSNotification *)notification{
    NSString * sceneName = [[notification userInfo] objectForKey:@"sceneName"];
    if([sceneName isEqualToString:@"Login"] == YES){
        [publicSetting removeLoadingAnimation:self];
        return;
    }
    else if([sceneName isEqualToString:@"LoginFail"] == YES){
        [publicSetting removeLoadingAnimation:self];
        [self setLoginComment:LOGIN_FAIL color:UIColorFromRGB(0xEF4089)];
        return;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * controller = [storyboard instantiateViewControllerWithIdentifier:sceneName];
    [self.navigationController pushViewController:controller animated:YES];
    [publicSetting removeLoadingAnimation:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
