//
//  RegisterModel.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 22..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterModel
{
    RegisterEmailViewController * controller;
}

- (id) init
{
    self = [super init];
    if (self) {
        controller = [[RegisterEmailViewController alloc] init];
    }
    return self;
}

-(id) initWithURLwithPort:(NSString *)URL port:(NSString *)port{
    if([super init]){
        NSString * address = [NSString stringWithFormat:@"http://%@:%@",URL,port];
        url = [[NSURL alloc]initWithString:address];
        request = [[NSMutableURLRequest alloc]initWithURL:url];
        request.HTTPMethod = @"POST";
        //[request setValue:@"applcation/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        //위에 코드는 에러가 자주남.....ㅠㅠ
    }
    return self;
}

-(void) successConnection:(NSString *)email:(NSString *)password:(NSString *)name{
    [request setURL:[url URLByAppendingPathComponent:@"/register"]];
    NSLog(@"현재 연결 url : %@", request.URL);
    registerData = [NSString stringWithFormat:@"email=%@&password=%@&userName=%@",email,password,name];
    resultData = [registerData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:resultData];
    
    NSHTTPURLResponse * sResponse;
    NSError * error;
    [publicSetting setLoadingAnimation:controller];
    resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&sResponse error:&error];
    [publicSetting removeLoadingAnimation:controller];
    NSLog(@"response = %ld", (long)sResponse.statusCode);
    NSLog(@"result = %@", [NSString stringWithUTF8String:resultData.bytes]);
}

-(BOOL)checkEmail:(NSString *) email{
    [request setURL:[url URLByAppendingPathComponent:@"/register/email"]];
    NSLog(@"현재 연결 url : %@", request.URL);
    registerData = [NSString stringWithFormat:@"email=%@",email];
    resultData = [registerData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:resultData];
    
    NSHTTPURLResponse * sResponse;
    NSError * error;
    [publicSetting setLoadingAnimation:controller];
    resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&sResponse error:&error];
    NSString * result = [NSString stringWithUTF8String:resultData.bytes];
    [publicSetting removeLoadingAnimation:controller];
    NSLog(@"response = %ld", (long)sResponse.statusCode);
    NSLog(@"result = %@", [NSString stringWithUTF8String:resultData.bytes]);

    if ([result isEqual: @"None"]){
        return YES;
    } else return NO;
}

@end


