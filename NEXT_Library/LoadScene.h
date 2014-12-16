//
//  LoadScene.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 16..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define storyboardName @"Main"

@interface LoadScene : NSObject

+(void)loadSceneByPush:(UIViewController *)currentViewController loadSceneName:(NSString *)sceneName;
+(void)loadSceneByModal:(UIViewController *)currentViewController loadSceneName:(NSString *)sceneName;

@end
