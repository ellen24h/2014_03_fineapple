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

+(id)sharedTimelineModel{
    static TimelineModel * model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        model = [[self alloc] initWithURLWithPortNum:[publicSetting getServerAddr] port:[publicSetting getPortNum]];
    });
    return model;
}

-(id)initWithURLWithPortNum:(NSString *)IPAddr port:(NSString *)port{
    if([super init]){
        NSString * addr = [NSString stringWithFormat:@"http://%@:%@",IPAddr,port];
        url = [[NSURL alloc]initWithString:addr];
        request = [[NSMutableURLRequest alloc]initWithURL:url];
        request.HTTPMethod = @"POST";
        [request setValue:@"applcation/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        timelineData_arr = [[NSMutableArray alloc]init];
        mypostData_arr = [[NSMutableArray alloc]init];
        lastTimelineId = -1;
        lastMypostId = -1;
    }

    return self;
}

-(void)getJsonFromServer:(NSString *)appRoute{
    [request setURL:[url URLByAppendingPathComponent:appRoute]];
    if([appRoute isEqualToString:@"/timeline"] == YES){
        dataType = TIMELINE_DATATYPE;
        timelineData = [[NSMutableData alloc]init];
        [request setValue:[NSString stringWithFormat:@"%d;",lastTimelineId] forHTTPHeaderField:@"Count"];
    }
    else{
        dataType = MYPOST_DATATYPE;
        mypostData = [[NSMutableData alloc]init];
        [request setValue:[NSString stringWithFormat:@"%d;",lastMypostId] forHTTPHeaderField:@"Count"];
    }
    NSLog(@"query to : %@",request.URL);
    NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(connection){
        NSLog(@"ConnectionSuccess");
    }
    else{
        NSLog(@"ConnectionFail");
    }

}

-(NSInteger)getCurTab{
    return dataType;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data{
    if (dataType == TIMELINE_DATATYPE)
        [timelineData appendData:data];
    else
        [mypostData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError * error;
    NSArray * data_arr;
    
    if(dataType == TIMELINE_DATATYPE){
        data_arr = [NSJSONSerialization JSONObjectWithData:timelineData options:kNilOptions error:&error];
       [timelineData_arr addObjectsFromArray:data_arr];
        if(data_arr.count > 0){
            lastTimelineId = [[[data_arr objectAtIndex:data_arr.count-1] objectForKey:@"postId"] integerValue];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"timelineJsonReceived" object:timelineData_arr];
    }
    else{
        data_arr = [NSJSONSerialization JSONObjectWithData:mypostData options:kNilOptions error:&error];
        [mypostData_arr addObjectsFromArray:data_arr];
        if(data_arr.count > 0){
            lastMypostId = [[[data_arr objectAtIndex:data_arr.count-1] objectForKey:@"postId"] integerValue];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"timelineJsonReceived" object:mypostData_arr];
    }
}


@end