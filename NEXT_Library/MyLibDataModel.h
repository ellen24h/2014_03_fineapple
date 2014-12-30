//
//  MyLibDataModel.h
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 30..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "publicSetting.h"

@interface MyLibDataModel : NSObject {
    NSURL * url;
    NSMutableURLRequest * request;
    NSData * resultData;
    NSString * registerData;
    
    // for Real Data Model
    NSMutableArray *my_Object;
    NSDictionary *dictionary;
    NSString *cover_img;
    NSString *ISBN;
}

@property (nonatomic, copy) NSString *imgPath;

+(id)sharedTimelineModel;
-(id) initWithURLwithPort:(NSString *)URL port:(NSString *)port;
- (NSUInteger)bookCount;
- (NSMutableArray *) returnMutableArray;
-(void)getReadBook;
-(void)getWishBook;

@end
