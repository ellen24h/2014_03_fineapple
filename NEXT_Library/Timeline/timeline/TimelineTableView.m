//
//  TimelineTableView.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 23..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "TimelineTableView.h"

@implementation TimelineTableView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;

    if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
    {
        //이부분 만약 TimelineModle을 싱글톤으로 구현하면 좋을것 같다.
        TimelineModel * model = [TimelineModel sharedTimelineModel];
        NSInteger curTab = [model getCurTab];
        NSString * approute;
        if(curTab == TIMELINE_DATATYPE){
            approute = @"/timeline";
        }
        else{
            approute = @"/mypost";
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loadMoreTimelineData" object:approute];
    }
}


@end
