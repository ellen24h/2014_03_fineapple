//
//  MyLibDataModel.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 30..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "MyLibDataModel.h"

@interface MyLibDataModel()
@end

@implementation MyLibDataModel

+(id)sharedTimelineModel{
    static MyLibDataModel * model = nil;
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
        
        _imgPath = self.imgPath;
        cover_img = @"cover_img";
        ISBN = @"bookISBN";
    }
    return self;
}

-(void)getReadBook{
    [request setURL:[url URLByAppendingPathComponent:@"/myReadBook"]]; // 책정보를 어디서 가지고 올 것인지...
    NSLog(@"현재 연결 url : %@", request.URL);
    NSData *jsonSource =  [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonSource options:kNilOptions error:nil];
    
    my_Object = [[NSMutableArray alloc] init];
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *ISBN_data = [dataDict objectForKey:@"bookISBN"];
        NSLog(@"bookISBN: %@", ISBN_data);
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      ISBN_data, ISBN,
                      nil];
        [my_Object addObject:dictionary];
    }
}
-(void)getWishBook{
    [request setURL:[url URLByAppendingPathComponent:@"/myWishBook"]]; // 책정보를 어디서 가지고 올 것인지...
    NSLog(@"현재 연결 url : %@", request.URL);
    NSData *jsonSource =  [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonSource options:kNilOptions error:nil];
    
    my_Object = [[NSMutableArray alloc] init];
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *ISBN_data = [dataDict objectForKey:@"bookISBN"];
        NSLog(@"bookISBN: %@", ISBN_data);
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      ISBN_data, ISBN,
                      nil];
        [my_Object addObject:dictionary];
    }
}
- (NSUInteger)bookCount{
    return my_Object.count;
}
// 데이터가 저장된 myObject를 넘겨주는 작업을 하는 메소드?
- (NSMutableArray *) returnMutableArray{
    return my_Object;
}

@end
