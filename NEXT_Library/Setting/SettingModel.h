//
//  SettingModel.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "publicSetting.h"


@interface SettingModel : NSObject
{
@private
    NSMutableURLRequest * request;
    NSURL * url;
}
+(id)sharedPostingModel;
-(void)modifyName:(NSString *)newName;
-(void)modifyPassword:(NSString *)newPassword;
-(NSDictionary *)getUserInfo;
-(void)logout;
@end