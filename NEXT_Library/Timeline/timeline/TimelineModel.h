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

@interface TimelineModel : NSObject
{
@private
    NSURL * url;
    NSMutableURLRequest * request;
    NSMutableData * timelineData;
}
-(id)initWithURLWithPortNum:(NSString *)IPAddr port:(NSString *)port;
-(void)getTimelineJsonFromServer;
@end