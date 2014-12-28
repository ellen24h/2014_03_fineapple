//
//  postingModel.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 27..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "publicSetting.h"
#import "serachResultBookButton.h"
#define NAVER_DISPLAY_NUM 5

@interface postingModel : NSObject<NSXMLParserDelegate>
{
@private
    postingModel * model;
    NSURL * serverUrl;
    NSURL * naverUrl;
    NSMutableURLRequest * serverRequest;
    NSMutableArray * bookData;
    NSMutableArray * subArray;
    NSMutableString * savedString;
    BOOL isStartItemSection;
    BOOL shouldSave;
}

+(id)sharedPostingModel;

@end