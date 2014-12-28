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

//keyboard 높이
#define kOFFSET_FOR_KEYBOARD 80.0

#define SERVER_ADDR @"0.0.0.0"
#define SERVER_PORT @"5013"
//NAVER books key
#define NAVERBOOKS_ADDRWITHKEY @"http://openapi.naver.com/search?key=435586f77d2ca2b1299622b362cebdf8"
#define NAVERBOOKS_KEY @"435586f77d2ca2b1299622b362cebdf8"
//loading화면 tag 상수 설정
#define LOADING_IMG_VIEW 4
#define LOADING_BACK_VIEW 5
//RGB값으로 UIColor 객체를 생성해주는 함수메크로
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//colors : RGBValue
#define FINE_PINK 0xEF4089
#define FINE_GREEN 0x19BDC4
#define FINE_BEIGE 0xFFF6EE
#define FINE_LIGHTGRAY 0xB3B3B3
#define FINE_DARKGRAY 0x4D4D4D

@interface publicSetting : NSObject

+(NSString *)getServerAddr;
+(NSString *)getPortNum;
+(NSString *)getNaverBooksKey;
+(NSString *)getNaverBooksAddrWithKey;
+(void)setLoadingAnimation:(UIViewController *)vc;
+(void)removeLoadingAnimation:(UIViewController *)vc;
@end