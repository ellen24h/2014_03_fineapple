//
//  NXBookDataModel.h
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 15..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "publicSetting.h"

@interface NXBookDataModel : NSObject {
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
    NSString *cover_img;
    NSString *book_num;
    NSString *ISBN;
}

@property (nonatomic, copy) NSString *bookTitle;
@property (nonatomic, copy) NSString *bookAuthor;
@property (nonatomic, copy) NSString *imgPath;

@property (nonatomic, readonly) NSMutableArray *bookList; // for set book first table test
+(id)sharedTimelineModel;
-(id) initWithURLwithPort:(NSString *)URL port:(NSString *)port;
-(void) getBookData;
- (NSUInteger)bookCount;
- (NSMutableArray *) returnMutableArray;

@end
