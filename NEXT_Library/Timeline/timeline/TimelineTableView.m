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
    
    if (scrollOffset == 0)
    {
        // then we are at the top
    }
    else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
    {
        NSLog(@"END");
    }
}


@end
