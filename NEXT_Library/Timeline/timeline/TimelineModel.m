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
        NSNotificationCenter * noti = [NSNotificationCenter defaultCenter];
        [noti addObserver:self selector:@selector(timelineLikeScrapButtonTouched:) name:@"timelineLikeScrapButtonTouched" object:nil];
        url = [[NSURL alloc]initWithString:addr];
        request = [[NSMutableURLRequest alloc]initWithURL:url];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        timelineData_arr = [[NSMutableArray alloc]init];
        mypostData_arr = [[NSMutableArray alloc]init];
        myLikeData_dic = [[NSMutableDictionary alloc]init];
        lastTimelineId = -1;
        lastMypostId = -1;
    }

    return self;
}
-(void)setLastMypostId:(NSUInteger)postId{
    lastMypostId = postId;
 
    if(postId == -1){
        timelineData_arr = [[NSMutableArray alloc]init];
        mypostData_arr = [[NSMutableArray alloc]init];
        myLikeData_dic = [[NSMutableDictionary alloc]init];
        lastTimelineId = -1;
    }
}

-(void)timelineLikeScrapButtonTouched:(NSNotification *)notification{
    [request setURL:[url URLByAppendingPathComponent:@"/timelineButton"]];
    timelineButton * button = notification.object;

    //action : active / inactive
    NSUInteger action = [button getStatus];
    //type : buttonType (like, scrap)
    NSString * type = [[button getButtonName] objectAtIndex:0];
    type = [type stringByReplacingOccurrencesOfString:@"_inactive.png" withString:@""];
    //key : postId
    NSUInteger key = button.tag;

    NSString * sendData_str = [[NSString alloc]initWithFormat:@"action=%d&type=%@&key=%d",action,type,key];
    NSData * sendData = [sendData_str dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:nil forHTTPHeaderField:@"Count"];
    [request setHTTPBody:sendData];
    [request setHTTPMethod:@"POST"];
    NSURLResponse * response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
}

-(void)getJsonFromServer:(NSString *)appRoute{
    [request setURL:[url URLByAppendingPathComponent:appRoute]];
    if([appRoute isEqualToString:@"/timeline"] == YES){
        dataType = TIMELINE_DATATYPE;
        timelineData = [[NSMutableData alloc]init];
        [request setValue:[NSString stringWithFormat:@"%d",lastTimelineId] forHTTPHeaderField:@"Count"];
    }
    else{
        dataType = MYPOST_DATATYPE;
        mypostData = [[NSMutableData alloc]init];
        [request setValue:[NSString stringWithFormat:@"%d",lastMypostId] forHTTPHeaderField:@"Count"];
    }
    NSLog(@"query to : %@",request.URL);
    NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(connection){
        NSLog(@"ConnectionSuccess");
        NSLog(@"lastMypostid : %d",lastMypostId);
        [request setValue:[NSString stringWithFormat:@"%d",lastMypostId] forHTTPHeaderField:@"Count"];
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
    [myLikeData_dic addEntriesFromDictionary:[self getMyLikeInfo]];
    if(dataType == TIMELINE_DATATYPE){
        data_arr = [NSJSONSerialization JSONObjectWithData:timelineData options:kNilOptions error:&error];
       [timelineData_arr addObjectsFromArray:data_arr];
        if(data_arr.count > 0){
            lastTimelineId = [[[data_arr objectAtIndex:data_arr.count-1] objectForKey:@"postId"] integerValue];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"timelineJsonReceived" object:timelineData_arr userInfo:myLikeData_dic];
    }
    else{
        data_arr = [NSJSONSerialization JSONObjectWithData:mypostData options:kNilOptions error:&error];
        [mypostData_arr addObjectsFromArray:data_arr];
        if(data_arr.count > 0){
            lastMypostId = [[[data_arr objectAtIndex:data_arr.count-1] objectForKey:@"postId"] integerValue];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"timelineJsonReceived" object:mypostData_arr userInfo:myLikeData_dic];
    }
}

-(NSDictionary *)getMyLikeInfo{
    NSDictionary * likeInfo_dic;
    NSData * likeInfo;
    
    [request setURL:[url URLByAppendingPathComponent:@"/getMyLikePostInfo"]];
    [request setValue:nil forHTTPHeaderField:@"Count"];
    [request setHTTPMethod:@"POST"];
   
    NSURLResponse * response;
    likeInfo = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    likeInfo_dic = [NSJSONSerialization JSONObjectWithData:likeInfo options:kNilOptions error:nil];
    return likeInfo_dic;
}


@end