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
        model = [[LoginModel alloc]initWithURLwithPort:SERVER_ADDR port:SERVER_PORT];
        NSNotificationCenter * notiCenter = [NSNotificationCenter defaultCenter];
        NSString * firstScene;
        [notiCenter addObserver:self selector:@selector(loadScene:) name:@"didSceneNameReceived" object:nil];
        firstScene = [model getFirstSceneNameFromServer];
        [self viewInitialize];
        [self setLoadingAnimation];
        if ([firstScene isEqualToString:@"Login"] == YES){
            [self removeLoadingAnimation];
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
    if( [_emailField.text isEqualToString:@""] != YES && [_passwordField.text isEqualToString:@""] != YES )
        [model signIn:_emailField.text password:_passwordField.text];
    else
        [self setLoginComment:LOGIN_FAIL color:UIColorFromRGB(0xEF4089)];
}

//setLoginComment
//  로그인 성공, 실패시 comment label에 해당하는 text 보여줌
-(void)setLoginComment:(NSString *)comment color:(UIColor *)commentColor{
    _comment.textColor = commentColor;
    _comment.text = comment;
}

//setLoadingAnimation
//  로딩애니메이션을 띄운다.
-(void)setLoadingAnimation{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 229, 100, 100)];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0,0,500,800)];
    imgView.animationImages = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"frame-000000.png"],
                               [UIImage imageNamed:@"frame-000001.png"],
                               [UIImage imageNamed:@"frame-000002.png"],
                               [UIImage imageNamed:@"frame-000003.png"],
                               [UIImage imageNamed:@"frame-000004.png"],
                               [UIImage imageNamed:@"frame-000005.png"],
                               [UIImage imageNamed:@"frame-000006.png"],
                               [UIImage imageNamed:@"frame-000007.png"],
                               [UIImage imageNamed:@"frame-000008.png"],
                               [UIImage imageNamed:@"frame-000009.png"],
                               [UIImage imageNamed:@"frame-000010.png"],
                               [UIImage imageNamed:@"frame-000011.png"],
                               [UIImage imageNamed:@"frame-000012.png"],
                               [UIImage imageNamed:@"frame-000013.png"],
                               [UIImage imageNamed:@"frame-000014.png"],
                               [UIImage imageNamed:@"frame-000015.png"],
                               [UIImage imageNamed:@"frame-000016.png"],
                               [UIImage imageNamed:@"frame-000017.png"],
                               [UIImage imageNamed:@"frame-000018.png"],
                               [UIImage imageNamed:@"frame-000019.png"],
                               [UIImage imageNamed:@"frame-000020.png"],
                               [UIImage imageNamed:@"frame-000021.png"],
                               [UIImage imageNamed:@"frame-000022.png"],
                               [UIImage imageNamed:@"frame-000023.png"],
                               [UIImage imageNamed:@"frame-000024.png"],
                               [UIImage imageNamed:@"frame-000025.png"],
                               [UIImage imageNamed:@"frame-000026.png"],
                               [UIImage imageNamed:@"frame-000027.png"],
                               [UIImage imageNamed:@"frame-000028.png"],
                               [UIImage imageNamed:@"frame-000029.png"],
                               [UIImage imageNamed:@"frame-000030.png"],
                               [UIImage imageNamed:@"frame-000031.png"],
                               [UIImage imageNamed:@"frame-000032.png"],
                               [UIImage imageNamed:@"frame-000033.png"],
                               [UIImage imageNamed:@"frame-000034.png"],
                               [UIImage imageNamed:@"frame-000035.png"],
                               [UIImage imageNamed:@"frame-000036.png"],
                               [UIImage imageNamed:@"frame-000037.png"],
                               [UIImage imageNamed:@"frame-000038.png"],
                               [UIImage imageNamed:@"frame-000039.png"],
                               [UIImage imageNamed:@"frame-000040.png"],
                               [UIImage imageNamed:@"frame-000041.png"],
                               [UIImage imageNamed:@"frame-000042.png"],
                               [UIImage imageNamed:@"frame-000043.png"],
                               [UIImage imageNamed:@"frame-000044.png"],
                               [UIImage imageNamed:@"frame-000045.png"],
                               [UIImage imageNamed:@"frame-000046.png"],
                               [UIImage imageNamed:@"frame-000047.png"],
                               [UIImage imageNamed:@"frame-000048.png"],
                               [UIImage imageNamed:@"frame-000049.png"],                             nil];
    [imgView setAnimationRepeatCount:-1];
    imgView.animationDuration = 1.5;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [imgView startAnimating];
    imgView.tag = LOADING_IMG_VIEW;
    backView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    backView.alpha = 0.8;
    backView.tag = LOADING_BACK_VIEW;
    [self.view addSubview:backView];
    [self.view addSubview:imgView];

}

//removeLoadingAnimation
//  로딩애니메이션 제거
-(void)removeLoadingAnimation{
    UIImageView * imgView = [self.view viewWithTag:LOADING_IMG_VIEW];
    UIView * backView = [self.view viewWithTag:LOADING_BACK_VIEW];
    [imgView stopAnimating];
    @autoreleasepool {
        imgView.animationImages = nil;
        [imgView removeFromSuperview];
        [backView removeFromSuperview];

        imgView = nil;
        backView = nil;
    }
}

//loadScene
//  서버로부터 사용자에게 보여줄 화면이름을 return받아서
//  다음 화면을 push하는 함수
- (void)loadScene:(NSNotification *)notification{
    NSString * sceneName = [[notification userInfo] objectForKey:@"sceneName"];
    if([sceneName isEqualToString:@"Login"] == YES){
        [self removeLoadingAnimation];
        return;
    }
    else if([sceneName isEqualToString:@"LoginFail"] == YES){
        [self removeLoadingAnimation];
        [self setLoginComment:LOGIN_FAIL color:UIColorFromRGB(0xEF4089)];
        return;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * controller = [storyboard instantiateViewControllerWithIdentifier:sceneName];
    [self.navigationController pushViewController:controller animated:YES];
    [self removeLoadingAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
