//
//  publicSetting.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 16..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoadScene.h"

#define SERVER_ADDR @"10.73.45.83"
#define SERVER_PORT @"5013"
//// loading화면 tag 상수 설정
#define LOADING_IMG_VIEW 4
#define LOADING_BACK_VIEW 5
//RGB값으로 UIColor 객체를 생성해주는 함수메크로
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface publicSetting : NSObject

+(NSString *)getServerAddr;
+(NSString *)getPortNum;
+(void)setLoadingAnimation:(UIViewController *)vc;
+(void)removeLoadingAnimation:(UIViewController *)vc;

@end