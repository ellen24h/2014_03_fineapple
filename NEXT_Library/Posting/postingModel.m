//
//  postingModel.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 27..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "postingModel.h"

@implementation postingModel

+(id)sharedPostingModel{
    static postingModel * model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        model = [[self alloc] initWithURLWithPortNum:[publicSetting getServerAddr] port:[publicSetting getPortNum]];
    });
    return model;
}

-(id)initWithURLWithPortNum:(NSString *)IPAddr port:(NSString *)port{
    if([super init]){
        NSString * addr = [NSString stringWithFormat:@"http://%@:%@",IPAddr,port];
        serverUrl = [[NSURL alloc]initWithString:addr];
        serverRequest = [[NSMutableURLRequest alloc]initWithURL:serverUrl];
        serverRequest.HTTPMethod = @"POST";
        [serverRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UITextFieldTextDidChangeNotification:) name:@"UITextFieldTextDidChangeNotification" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(postingSendToServer:) name:@"postingSendToServer" object:nil];
    }
    
    return self;
}

-(void)postingSendToServer:(NSNotification *)noti{
    NSDictionary * postInfo = noti.object;
    [serverRequest setURL:[serverUrl URLByAppendingPathComponent:@"/posting"]];
    serverRequest.HTTPMethod = @"POST";
    [serverRequest setHTTPBody:[[NSString stringWithFormat:@"post=%@&postImg=%@&postISBN=%@",[postInfo objectForKey:@"post"],[[[postInfo objectForKey:@"postImg"] componentsSeparatedByString:@"?"]objectAtIndex:0],[postInfo objectForKey:@"postISBN"]] dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:serverRequest delegate:self];
    if(connection){
        NSLog(@"connection success!");
    }
    else{
        NSLog(@"connection fail!");
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"postingDone" object:nil];
}

-(void)UITextFieldTextDidChangeNotification:(NSNotification *)noti{
    UITextField * searchTextField = noti.object;
    NSString * searchQuery = searchTextField.text;
       //검색하려는 문구가 전부 지워졌을때
    if([searchTextField.text isEqualToString:@""] == YES){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"naverBookData" object:NULL];
    }
    else{
        naverUrl = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@&query=%@&display=%d&target=book",[publicSetting getNaverBooksAddrWithKey],[searchQuery stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],NAVER_DISPLAY_NUM]];
        savedString = [[NSMutableString alloc]initWithFormat:@""];
        bookData = [[NSMutableArray alloc]init];
        NSXMLParser * paser = [[NSXMLParser alloc]initWithContentsOfURL:naverUrl];
        paser.delegate = self;
        [paser parse];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"naverBookData" object:bookData];
    }

}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    isStartItemSection = NO;
    shouldSave = NO;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if(isStartItemSection == NO){
        if([elementName isEqualToString:@"item"] == YES){
            isStartItemSection = YES;
        }
    }
    else if(isStartItemSection == YES){
        if([elementName isEqualToString:@"title"] == YES||
           [elementName isEqualToString:@"image"] == YES||
           [elementName isEqualToString:@"author"] == YES||
           [elementName isEqualToString:@"isbn"] == YES
           ){
            shouldSave = YES;
        }
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(isStartItemSection == YES && shouldSave == YES){
        [savedString appendString:string];
    }
    

}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if(shouldSave == YES){
        if([elementName isEqualToString:@"title"] == YES){
            shouldSave = NO;
           
            subArray = [[NSMutableArray alloc]initWithObjects:[NSString stringWithString:[[NSString stringWithString:[savedString stringByReplacingOccurrencesOfString:@"<b>" withString:@""]] stringByReplacingOccurrencesOfString:@"</b>" withString:@""]], nil];
            [savedString setString:@""];
        }
        else if([elementName isEqualToString:@"image"] == YES ||
           [elementName isEqualToString:@"author"] == YES){
            shouldSave = NO;
            ;
            
            [subArray addObject:[[NSString stringWithString:[savedString stringByReplacingOccurrencesOfString:@"<b>" withString:@""]] stringByReplacingOccurrencesOfString:@"</b>" withString:@""]];
            [savedString setString:@""];
        }
        else if([elementName isEqualToString:@"isbn"] == YES){
            shouldSave = NO;
            
            [subArray addObject:[[NSString stringWithString:[savedString stringByReplacingOccurrencesOfString:@"<b>" withString:@""]] stringByReplacingOccurrencesOfString:@"</b>" withString:@""]];
            [bookData addObject:subArray];
            [savedString setString:@""];
        }
    }


}



@end
