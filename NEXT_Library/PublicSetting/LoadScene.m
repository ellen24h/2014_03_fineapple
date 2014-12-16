//
//  LoadScene.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 16..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "LoadScene.h"

@implementation LoadScene

//반드시 load할 scene의 storyboard ID가 유효해야 오류없이 화면 전환됩니다.

+(void)loadSceneByPush:(UIViewController *)currentViewController loadSceneName:(NSString *)sceneName{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController * controller = [storyboard instantiateViewControllerWithIdentifier:sceneName];
    [currentViewController.navigationController pushViewController:controller animated:YES];
}
+(void)loadSceneByModal:(UIViewController *)currentViewController loadSceneName:(NSString *)sceneName{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController * controller = [storyboard instantiateViewControllerWithIdentifier:sceneName];
    [currentViewController presentViewController:controller animated:YES completion:nil];
}

@end
