//
//  NXBookDataModel.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 15..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "NXBookDataModel.h"
#import <ImageIO/CGImageSource.h>


@implementation NXBookDataModel
{
    NSMutableDictionary * _bookDictionary;
    NSMutableArray * _bookArray;
    NSMutableData * _responseData;
    NSString * _bookName;
    NSString * _bookAuthor;
    NSString * _bookISBN;
    
}

-(id)init {
    self = [super init];
    
    if (self) {
        _responseData = [[NSMutableData alloc] initWithCapacity:10];
        NSString * URLString = @"http://10.73.45.83:5000/[here is route account]";
        NSURL * url = [NSURL URLWithString:URLString];
        NSURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        NSConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        NSData * testData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://gooruism.com/feed/json"]];
    }
    return self;
}

-(NSString *)description {
    return _bookDictionary.description;
}



@end
