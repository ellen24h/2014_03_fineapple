//
//  BookDetailModel.h
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "publicSetting.h"

@interface BookDetailModel : NSObject {
    // for server connect
    NSURL * url;
    NSMutableURLRequest * request;
    NSData * resultData;
    NSString * registerData;
    
    // for Real Data Model
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *name;
    NSString *author;
    NSString *bookImg;
    NSString *bookNum;
    NSString *publish_year;
    NSString *large_ctag;
    NSString *medium_ctag;
    NSString *small_ctag;
    NSString *location;
    NSString *description;
    NSString *ISBN;
}
@property (nonatomic, copy) NSMutableArray * myObject;

+(id)sharedTimelineModel;
-(id) initWithURLwithPort:(NSString *)URL port:(NSString *)port;
-(void)getDetailData:(NSString *)booknum;
-(void)getDescription;
-(NSString *)readCount:(NSString *)book_isbn;
-(NSString *)wishCount:(NSString *)book_isbn;
-(NSMutableArray *)getObject;

@end


