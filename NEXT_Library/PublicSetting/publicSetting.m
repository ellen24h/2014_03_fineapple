//
//  publicSetting.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 16..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "publicSetting.h"

@implementation publicSetting

+(NSString *)getServerAddr{
    return SERVER_ADDR;
}
+(NSString *)getPortNum{
    return SERVER_PORT;
}
+(NSString *)getNaverBooksKey{
    return NAVERBOOKS_KEY;
}
+(NSString *)getNaverBooksAddrWithKey{
    return NAVERBOOKS_ADDRWITHKEY;
}
//setLoadingAnimation
//  로딩애니메이션을 띄운다.
+(void)setLoadingAnimation:(UIViewController *) vc{
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
    [vc.view addSubview:backView];
    [vc.view addSubview:imgView];
    
}

//removeLoadingAnimation
//  로딩애니메이션 제거
+(void)removeLoadingAnimation:(UIViewController *)vc{
    UIImageView * imgView = [vc.view viewWithTag:LOADING_IMG_VIEW];
    UIView * backView = [vc.view viewWithTag:LOADING_BACK_VIEW];
    [imgView stopAnimating];
    @autoreleasepool {
        imgView.animationImages = nil;
        [imgView removeFromSuperview];
        [backView removeFromSuperview];
        
        imgView = nil;
        backView = nil;
    }
}

+(NSString*) sha1:(NSString*)input
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
