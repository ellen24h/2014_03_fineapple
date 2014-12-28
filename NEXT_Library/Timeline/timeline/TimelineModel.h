//
//  TimelineModel.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 20..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKIt/UIKIt.h>
#import "publicSetting.h"
#import "timelineButton.h"

#define TIMELINE_DATATYPE 0
#define MYPOST_DATATYPE 1

@interface TimelineModel : NSObject
{
@private
    NSURL * url;
    NSMutableURLRequest * request;
    NSInteger dataType;
    NSMutableArray * timelineData_arr;
    NSMutableArray * mypostData_arr;
    NSMutableDictionary * myLikeData_dic;
    NSMutableData * timelineData;
    NSMutableData * mypostData;
    NSInteger lastTimelineId;
    NSInteger lastMypostId;
}
+(id)sharedTimelineModel;
-(id)initWithURLWithPortNum:(NSString *)IPAddr port:(NSString *)port;
-(void)getJsonFromServer:(NSString *)appRoute;
-(NSInteger)getCurTab;
-(NSDictionary *)getMyLikeInfo;
-(void)setLastMypostId:(NSUInteger)postId;
@end