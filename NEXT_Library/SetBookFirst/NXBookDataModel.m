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
{
    NSMutableArray *myObject;
    // A dictionary object
    NSDictionary *dictionary;
    // Define keys
    NSString *name;
    NSString *author;
    NSString *cover_img;
    NSString *book_num;
    NSMutableArray *readObject;
    NSMutableArray *wishObject;
}

@end

@implementation NXBookDataModel

-(id)init {
    self = [super init];
    
    if (self) {
        _bookTitle = self.bookTitle;
        _bookAuthor = self.bookAuthor;
        _imgPath = self.imgPath;
        _bookList = [[NSMutableArray alloc] init];
        
        name = @"name";
        author = @"author";
        cover_img = @"cover_img";
        book_num = @"book_num";
        myObject = [[NSMutableArray alloc] init];
        
        [self initializeDefaultBook];
        return self;
    }
    return nil;
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
        myObject = [[NSMutableArray alloc] init];
        
        //[request setValue:@"applcation/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        //위에 코드는 에러가 자주남.....ㅠㅠ
    }
    return self;
}

-(void) getBookData{
    [request setURL:[url URLByAppendingPathComponent:@"/setBookFirst"]];
    NSLog(@"현재 연결 url : %@", request.URL);
    NSData *jsonSource =  [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonSource options:kNilOptions error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *name_data = [dataDict objectForKey:@"name"];
        NSString *author_data = [dataDict objectForKey:@"author"];
        NSString *cover_img_data = [dataDict objectForKey:@"cover_img"];
        NSString *book_num_data = [dataDict objectForKey:@"book_num"];
        
        NSLog(@"name: %@",name);
        NSLog(@"author: %@",author_data);
        NSLog(@"cover_img: %@",cover_img_data);
        NSLog(@"book_num: %@",book_num_data);
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      name_data, name,
                      author_data, author,
                      cover_img_data, cover_img,
                      book_num_data, book_num,
                      nil];
        [myObject addObject:dictionary];
    }
}
- (NSUInteger)bookCount{
    return myObject.count;
}
- (NSMutableArray *) returnMutableArray{
    return myObject;
}

- (void)setReadbook:(NSInteger)row {
    
}

@end