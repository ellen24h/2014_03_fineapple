//
//  BookDetailModel.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "BookDetailModel.h"

@implementation BookDetailModel

+(id)sharedTimelineModel{
    static BookDetailModel * model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        model = [[self alloc] initWithURLwithPort:[publicSetting getServerAddr] port:[publicSetting getPortNum]];
    });
    return model;
}

-(id) initWithURLwithPort:(NSString *)URL port:(NSString *)port{
    if([super init]){
        NSString * address = [NSString stringWithFormat:@"http://%@:%@",URL,port];
        url = [[NSURL alloc]initWithString:address];
        request = [[NSMutableURLRequest alloc]initWithURL:url];
        request.HTTPMethod = @"POST";
        
        name = @"name";
        author = @"author";
        bookImg = @"cover_img";
        bookNum = @"book_num";
        publish_year = @"publish_year";
        large_ctag = @"large_ctag";
        medium_ctag = @"medium_ctag";
        small_ctag = @"small_ctag";
        location = @"locataion1";
        description = @"description";
        ISBN = @"ISBN";
        myObject = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)getDetailData:(NSString *)booknum{
    [request setURL:[url URLByAppendingPathComponent:@"/bookDetail"]];
    NSLog(@"현재 연결 url : %@", request.URL);
    NSString * bookData = [NSString stringWithFormat:@"book_num=%@",booknum];
    resultData = [bookData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:resultData];
    
    NSData *book_Data =  [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *bookObjects= [NSJSONSerialization JSONObjectWithData:book_Data options:kNilOptions error:nil];
    
    for (NSDictionary *dataDict in bookObjects) {
        NSString *name_data = [dataDict objectForKey:@"name"];
        NSString *author_data = [dataDict objectForKey:@"author"];
        NSString *cover_img_data = [dataDict objectForKey:@"cover_img"];
        NSString *book_num_data = [dataDict objectForKey:@"book_num"];
        NSString *publish_year_data = [dataDict objectForKey:@"publish_year"];
        NSString *large_ctag_data = [dataDict objectForKey:@"large_ctag"];
        NSString *medium_ctag_data = [dataDict objectForKey:@"medium_ctag"];
        NSString *small_ctag_data = [dataDict objectForKey:@"small_ctag"];
        NSString *location_data = [dataDict objectForKey:@"locataion1"];
        NSString *ISBN_data = [dataDict objectForKey:@"ISBN"];

        NSLog(@"name: %@",name_data);
        NSLog(@"book_num: %@",book_num_data);
        NSLog(@"ISBN: %@", ISBN_data);
    
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      name_data, name,
                      author_data, author,
                      cover_img_data, bookImg,
                      book_num_data, bookNum,
                      publish_year_data, publish_year,
                      large_ctag_data, large_ctag,
                      medium_ctag_data, medium_ctag,
                      small_ctag_data, small_ctag,
                      location_data, location,
                      ISBN_data, ISBN,
                      nil];
        [myObject addObject:dictionary];
    }
}

-(void)getDescription{
    
}

-(NSString *)readCount:(NSString *)book_isbn {
    [request setURL:[url URLByAppendingPathComponent:@"/count"]];
    NSString * bookISBN = [NSString stringWithFormat:@"ISBN=%@",book_isbn];
    resultData = [bookISBN dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:resultData];
    
    NSData *count_Data =  [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *count_Objects = [NSJSONSerialization JSONObjectWithData:count_Data options:kNilOptions error:nil];
    
    NSString * read_count;
    for (NSDictionary *dataDict in count_Objects) {
        read_count = [dataDict objectForKey:@"READ_count"];
    }
    return read_count;
}

-(NSString *)wishCount:(NSString *)book_isbn  {
    NSData *count_Data =  [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *count_Objects = [NSJSONSerialization JSONObjectWithData:count_Data options:kNilOptions error:nil];
    
    NSString * wish_count;
    for (NSDictionary *dataDict in count_Objects) {
        wish_count = [dataDict objectForKey:@"WISH_count"];
    }
    return wish_count;
}

-(NSMutableArray *)getObject{
    return myObject;
}

@end
