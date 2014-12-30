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
        location = @"location1";
        description = @"description";
        ISBN = @"ISBN";
    }
    return self;
}

-(void)getDetailData:(NSString *)getISBN{
    NSString *name_data;
    NSString *author_data;
    NSString *cover_img_data;
    NSString *book_num_data;
    NSString *publish_year_data;
    NSString *large_ctag_data;
    NSString *medium_ctag_data;
    NSString *small_ctag_data;
    NSString *location_data;
    NSString *ISBN_data;

    [request setURL:[url URLByAppendingPathComponent:@"/bookDetail"]];
    NSString * bookData = [NSString stringWithFormat:@"ISBN=%@",getISBN];
    resultData = [bookData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:resultData];
    
    NSData *book_Data =  [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *bookObjects= [NSJSONSerialization JSONObjectWithData:book_Data options:kNilOptions error:nil];
    NSLog(@"%@",bookObjects);
    if(bookObjects.count == 0){
        NSURL * url_daum = [NSURL URLWithString:[NSString stringWithFormat:@"http://apis.daum.net/search/book?q=%@&apikey=ae04be3ff84bfb7d678768b3270dbd5d63741b41&output=json&searchType=isbn",getISBN]];
        NSLog(@"%@",url_daum);
        NSURLResponse * response;
        [request setURL:url_daum];
        request.HTTPMethod=@"GET";
        NSData * daumData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        NSLog(@"%@",daumData);
        NSMutableDictionary * daumData_dic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:daumData options:kNilOptions error:nil]];
        NSLog(@"dict : %@",daumData_dic);
        
        NSDictionary * book = [[daumData_dic objectForKey:@"channel"] objectForKey:@"item"];
        name_data = [book objectForKey:@"title"];
        author_data = [book objectForKey:@"author_t"];
        cover_img_data = [book objectForKey:@"cover_l_url"];
        publish_year_data = [book objectForKey:@"pub_date"];
        large_ctag_data = [book objectForKey:@"category"];
        medium_ctag_data = [book objectForKey:@"category"];
        small_ctag_data = [book objectForKey:@"category"];
        location_data = @"도서없음";
        ISBN_data = [book objectForKey:@"isbn"];
    }
    else{
        for (NSDictionary *dataDict in bookObjects) {
            name_data = [dataDict objectForKey:@"name"];
            author_data = [dataDict objectForKey:@"author"];
            cover_img_data = [dataDict objectForKey:@"cover_img"];
            book_num_data = [dataDict objectForKey:@"book_num"];
            publish_year_data = [dataDict objectForKey:@"publish_year"];
            large_ctag_data = [dataDict objectForKey:@"large_ctag"];
            medium_ctag_data = [dataDict objectForKey:@"medium_ctag"];
            small_ctag_data = [dataDict objectForKey:@"small_ctag"];
            location_data = [dataDict objectForKey:@"location1"];
            ISBN_data = [dataDict objectForKey:@"ISBN"];
    }
        
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

        _myObject = [[NSMutableArray alloc]initWithObjects:dictionary, nil];
 
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
    [request setURL:[url URLByAppendingPathComponent:@"/count"]];
    
    NSString * bookISBN = [NSString stringWithFormat:@"ISBN=%@",book_isbn];
    resultData = [bookISBN dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:resultData];
    
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
