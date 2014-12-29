//
//  NXBookDataModel.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 15..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "NXBookDataModel.h"
#import <ImageIO/CGImageSource.h>
#import "publicSetting.h"

@interface NXBookDataModel()
@end

@implementation NXBookDataModel

+(id)sharedTimelineModel{
    static NXBookDataModel * model = nil;
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
        
        _bookTitle = self.bookTitle;
        _bookAuthor = self.bookAuthor;
        _imgPath = self.imgPath;
        _bookList = [[NSMutableArray alloc] init];
        
        name = @"name";
        author = @"author";
        cover_img = @"cover_img";
        book_num = @"book_num";
        ISBN = @"ISBN";
        myObject = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) postReadData:(NSMutableArray *)setRead {
    NSMutableString * readISBN = [[NSMutableString alloc] init];
    for (int i = 0; i < [setRead count]; i++){
        NSString *nth = [NSString stringWithFormat:@"%d",i];
        nth = [NSString stringWithFormat:@"%d",i];
        [readISBN appendString:nth];
        [readISBN appendString:@"="];
        NSString *isbn = [NSString stringWithFormat:@"%@",setRead[i]];
        [readISBN appendString:isbn];
        [readISBN appendString:@"&"];
        NSLog(@"%@",readISBN);
    }
    
//    NSString *alertString = [NSString stringWithFormat:@"%@",setRead];
//    NSLog(@"%@",alertString);
//    NSData *readJsonData = [NSJSONSerialization dataWithJSONObject:setRead options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *readJsonString = [[NSString alloc] initWithData:readJsonData encoding:NSUTF8StringEncoding];
    
    NSData *requestData = [readISBN dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setURL:[url URLByAppendingPathComponent:@"/readBook"]];
    [request setHTTPBody:requestData];
    
    NSHTTPURLResponse * sResponse;
    NSError * error;
    resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&sResponse error:&error];
    NSLog(@"response = %ld", (long)sResponse.statusCode);
    NSLog(@"result = %@", [NSString stringWithUTF8String:resultData.bytes]);
}

-(void) postWishData:(NSMutableArray *)setWish {
    NSMutableString * wishISBN = [[NSMutableString alloc] init];
    for (int i = 0; i < [setWish count]; i++){
        NSString *nth = [NSString stringWithFormat:@"%d",i];
        nth = [NSString stringWithFormat:@"%d",i];
        [wishISBN appendString:nth];
        [wishISBN appendString:@"="];
        NSString *isbn = [NSString stringWithFormat:@"%@",setWish[i]];
        [wishISBN appendString:isbn];
        [wishISBN appendString:@"&"];
        NSLog(@"%@",wishISBN);
    }
    
    //    NSString *alertString = [NSString stringWithFormat:@"%@",setRead];
    //    NSLog(@"%@",alertString);
    //    NSData *readJsonData = [NSJSONSerialization dataWithJSONObject:setRead options:NSJSONWritingPrettyPrinted error:nil];
    //    NSString *readJsonString = [[NSString alloc] initWithData:readJsonData encoding:NSUTF8StringEncoding];
    
    NSData *requestData = [wishISBN dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setURL:[url URLByAppendingPathComponent:@"/wishBook"]];
    [request setHTTPBody:requestData];
    
    NSHTTPURLResponse * sResponse;
    NSError * error;
    resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&sResponse error:&error];
    NSLog(@"response = %ld", (long)sResponse.statusCode);
    NSLog(@"result = %@", [NSString stringWithUTF8String:resultData.bytes]);
}

-(void) getBookData {
    
    [request setURL:[url URLByAppendingPathComponent:@"/setBookFirst"]]; // 책정보를 어디서 가지고 올 것인지...
    NSLog(@"현재 연결 url : %@", request.URL);
    
    // 책정보 받아서 (해당 부분은 서버에서 json file로 보냄) json 형태로 파싱하여 데이터를 저장.
    NSData *jsonSource =  [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonSource options:kNilOptions error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *name_data = [dataDict objectForKey:@"name"];
        NSString *author_data = [dataDict objectForKey:@"author"];
        NSString *cover_img_data = [dataDict objectForKey:@"cover_img"];
        NSString *book_num_data = [dataDict objectForKey:@"book_num"];
        NSString *ISBN_data = [dataDict objectForKey:@"ISBN"];
        
        NSLog(@"name: %@",name_data);
        NSLog(@"author: %@",author_data);
        NSLog(@"cover_img: %@",cover_img_data);
        NSLog(@"book_num: %@",book_num_data);
        NSLog(@"ISBN: %@", ISBN_data);
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      name_data, name,
                      author_data, author,
                      cover_img_data, cover_img,
                      book_num_data, book_num,
                      ISBN_data, ISBN,
                      nil];
        [myObject addObject:dictionary];
    }
}

// 전체 책 개수를 리턴하는 메소드인데... 왜 짰지?
- (NSUInteger)bookCount{
    return myObject.count;
}

// 데이터가 저장된 myObject를 넘겨주는 작업을 하는 메소드?
- (NSMutableArray *) returnMutableArray{
    return myObject;
}

@end