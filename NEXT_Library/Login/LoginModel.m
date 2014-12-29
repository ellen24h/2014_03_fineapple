//
//  LoginModel.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 9..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

//initWithURLwithPort
//  model객체(일까 채일까?아무튼..)를 생성할 때 파라미터로 URL과 포트번호를 받아
//  model객체의 변수인 request를 setting하는 init
-(id) initWithURLwithPort:(NSString *)URL port:(NSString *)port{
    if([super init]){

        serverURL= [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@",URL,port]];
        request = [[NSMutableURLRequest alloc]init];
        recvData = [[NSMutableData alloc] init];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        //application/x-www-form-urlencoded 방식을 선택하면, key-value 형태로 인코딩 하게 된다.
        //따라서 POST 방식으로 전송할 때 Content-Type을 application/x-www-form-urlencoded로 써야 한다.
    }
    return self;
}


//UserDefaults로부터 session과 remember_token을 받아온다.
-(NSString *)getSessionFromUserDefault{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"session"];
}

-(NSString *)getRememberTokenFromUserDefault{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"remember_token"];
}

//getFisrtSceneNameFromServer
//  사용자가 처음 앱을 켜면 어떤 화면을 띄워줘야 하는지 서버에 쿼리하여 화면 이름을 서버로부터 받아옴
-(NSString *)getFirstSceneNameFromServer{
    NSString * rememberToken = [self getRememberTokenFromUserDefault];
    NSLog(@"%@",rememberToken);
    if(rememberToken != NULL){
        [request setURL:[serverURL URLByAppendingPathComponent:@"/veryFirstConnect"]];
        [request setValue:[NSString stringWithFormat:@"remember_token=%@",rememberToken] forHTTPHeaderField:@"Cookie"];
        NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        if(connection){
            NSLog(@"connection success");
            return NULL;
        }
        else{
            NSLog(@"connection fail");
            return @"Login";
        }
    }
    else{
        return @"Login";
    }

}


//connection : didReceiveResponse
//  서버로부터 response를 받았을 때, session, remember_token이 userDefaults에 없다면,
//  userDefault에 session, remember_token 을 저장
-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    NSUserDefaults * pref = [NSUserDefaults standardUserDefaults];
    if([pref objectForKey:@"session"] == NULL || [pref objectForKey:@"remember_token"] == NULL){
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)response;
        NSDictionary * dictionary;
        if ([response respondsToSelector:@selector(allHeaderFields)]) {
            dictionary = [httpResponse allHeaderFields];
        }
        NSArray * keys = [dictionary allKeys];
        if([keys containsObject:@"Set-Cookie"] == YES){
            NSString * cookie_str = [[dictionary valueForKey:@"Set-Cookie"]stringByReplacingOccurrencesOfString:@"Path=/," withString:@""];
            NSArray * cookie_arr = [cookie_str componentsSeparatedByString:@";"];
            NSString * rememberToken = [[[cookie_arr objectAtIndex:0] componentsSeparatedByString:@"="]objectAtIndex:1];
            NSString * session = [[[cookie_arr objectAtIndex:2] componentsSeparatedByString:@"="]objectAtIndex:1];
            [pref setObject:rememberToken forKey : @"remember_token"];
            [pref setObject:session forKey : @"session"];
            [pref synchronize];
        }
    }
}

//connection : didReceiveData
//  server로부터 data 수신을 완료했을때, notificationCenter에 didSceneNameReceived라는 이름으로 알림
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString * recvData_str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary * sceneName = [NSDictionary dictionaryWithObject:recvData_str forKey:@"sceneName"];
    NSLog(@"recvData From Server : %@",recvData_str);
      [[NSNotificationCenter defaultCenter] postNotificationName:@"didSceneNameReceived" object:self userInfo:sceneName];
}


//signIn
//  서버에 사용자 이메일과 비밀번호를 post data로 전송
//  비밀번호의 경우 sha1함수로 encrypt하여 전송
- (void)signIn:(NSString *)email password:(NSString *)password{
    @autoreleasepool {
        password = [self sha1:password];
        NSString * userData = [[NSString alloc] initWithFormat:@"email=%@&password=%@",email,password];
        NSData * postData = [userData dataUsingEncoding:NSUTF8StringEncoding];
        NSString * dataLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
       [request setURL:[serverURL URLByAppendingPathComponent:@"/login"]];
       [request setValue:dataLength forHTTPHeaderField:@"Content-Length"];
       [request setHTTPBody:postData];
       NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        if(connection){
            NSLog(@"connection success");
        }
        else{
            NSLog(@"connection fail");
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


@end
