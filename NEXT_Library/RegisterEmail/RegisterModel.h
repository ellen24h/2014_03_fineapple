//
//  RegisterModel.h
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 22..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterEmailViewController.h"
#import "publicSetting.h"

@interface RegisterModel : NSObject
{
@private
    NSURL * url;
    NSMutableURLRequest * request;
    NSData * resultData;
    NSString * registerData;
}
-(id) initWithURLwithPort:(NSString *)URL port:(NSString *)port;
-(void) successConnection:(NSString *)email:(NSString *)password:(NSString *)name;
-(BOOL)checkEmail:(NSString *) email;


@end
