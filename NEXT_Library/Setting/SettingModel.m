//
//  SettingModel.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "SettingModel.h"

@implementation SettingModel

+(id)sharedPostingModel{
    static SettingModel * model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        model = [[self alloc] initWithURLWithPortNum:[publicSetting getServerAddr] port:[publicSetting getPortNum]];
    });
    return model;
}

-(id)initWithURLWithPortNum:(NSString *)IPAddr port:(NSString *)port{
    if([super init]){
        NSString * addr = [NSString stringWithFormat:@"http://%@:%@",IPAddr,port];
        url = [[NSURL alloc]initWithString:addr];
        request = [[NSMutableURLRequest alloc]initWithURL:url];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    
    return self;
}
-(void)modifyName:(NSString *)newName{
    NSURLResponse * response;
    [request setURL:[url URLByAppendingPathComponent:@"/modifyName"]];
    [request setHTTPBody:[[NSString stringWithFormat:@"newName=%@",newName]dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
}

-(void)modifyPassword:(NSString *)newPassword{
    NSURLResponse * response;
    [request setURL:[url URLByAppendingPathComponent:@"/modifyPassword"]];
    [request setHTTPBody:[[NSString stringWithFormat:@"newPassword=%@",newPassword]dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)response;
    NSDictionary * dictionary;
    NSUserDefaults * pref = [NSUserDefaults standardUserDefaults];
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
        [request setValue:[NSString stringWithFormat:@"remember_token=%@",rememberToken] forHTTPHeaderField:@"Cookie"];
        NSLog(@"%@",rememberToken);
    }
    
    
    NSLog(@"%@",response);
    
}

-(NSDictionary *)getUserInfo{
    NSMutableDictionary * result =[[NSMutableDictionary alloc]init];
    NSData * data;
    NSURLResponse * response;
    [request setURL:[url URLByAppendingPathComponent:@"/getUserInfo"]];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return result;
}

@end