//
//  TimelineModel.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 20..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimelineModel.h"

@implementation TimelineModel

-(id)initWithURLWithPortNum:(NSString *)IPAddr port:(NSString *)port{
    if([super init]){
        NSString * addr = [NSString stringWithFormat:@"http://%@:%@",IPAddr,port];
        url = [[NSURL alloc]initWithString:addr];
        request = [[NSMutableURLRequest alloc]initWithURL:url];
        request.HTTPMethod = @"POST";
        [request setValue:@"applcation/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }

    return self;
}

-(void)getTimelineJsonFromServer{
    [request setURL:[url URLByAppendingPathComponent:@"/timeline"]];
    NSLog(@"%@",request.URL);
    NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(connection){
        NSLog(@"ConnectionSuccess");
        timelineData = [[NSMutableData alloc]init];
    }
    else{
        NSLog(@"ConnectionFail");
    }

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data{
    [timelineData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError * error;
    NSArray * data_arr = [NSJSONSerialization JSONObjectWithData:timelineData options:kNilOptions error:&error];

     [[NSNotificationCenter defaultCenter] postNotificationName:@"timelineJsonReceived" object:data_arr];
}


@end