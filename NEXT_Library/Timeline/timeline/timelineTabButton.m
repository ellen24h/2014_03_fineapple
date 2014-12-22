//
//  timelineTabButton.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 21..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "timelineTabButton.h"

@implementation timelineTabButton

-(void)setStatus:(int)newStatus{
    status = newStatus;
    if(newStatus == INACTIVE)
        self.backgroundColor = UIColorFromRGB(INACTIVE_COLOR);
    else
        self.backgroundColor = UIColorFromRGB(ACTIVE_COLOR);
}

-(void)registerNotiCenter{
    [self addTarget:self action:@selector(tabButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    NSNotificationCenter * noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(touched:) name:@"tabButtonTouched" object:nil];
}

-(void)tabButtonTouched{
    if(status == INACTIVE)
        [[NSNotificationCenter defaultCenter]postNotificationName:@"tabButtonTouched" object:self];
}

-(void)touched:(timelineTabButton *)touchedButton{
    if (status == INACTIVE){
        [self setStatus:ACTIVE];
        //타임라인, 내게시물 이라는 노티피케이션 등록
        [[NSNotificationCenter defaultCenter]postNotificationName:self.titleLabel.text object:self.titleLabel.text];

    }
    else
        [self setStatus:INACTIVE];
}

-(int)getStatus{
    return status;
}

@end
