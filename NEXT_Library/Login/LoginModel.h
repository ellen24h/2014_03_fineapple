//
//  LoginModel.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 9..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface LoginModel : NSObject
{
@public
    NSMutableData * recvData;
    NSMutableURLRequest * request;
    NSURL * serverURL;
}
-(id) initWithURLwithPort:(NSString *)URL port:(NSString *)port;
-(NSString *)getSessionFromUserDefault;
-(NSString *)getFirstSceneNameFromServer;
- (void)signIn:(NSString *)email password:(NSString *)password;
@end
