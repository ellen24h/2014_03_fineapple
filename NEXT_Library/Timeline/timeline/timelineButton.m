//
//  timelineButton.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 20..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "timelineButton.h"



@implementation timelineButton
-(id)initWithButtonName:(NSString *)inactiveButtonImg activeButtonImg:(NSString *)activeButtonImg{
    if([self init]){
        buttonName = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@.png",inactiveButtonImg],[NSString stringWithFormat:@"%@.png",activeButtonImg], nil];
    }
    [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",inactiveButtonImg]] forState:UIControlStateNormal];
    [self addTarget:self action:@selector(touched) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

-(void)touched{
    
    if(status == ACTIVE){
        [self setStatus:INACTIVE];
    }
    else{
        [self setStatus:ACTIVE];
    }
    //like, scrap버튼을 눌렀을 경우
    if([[buttonName objectAtIndex:0] rangeOfString:@"comment"].location == NSNotFound){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"timelineLikeScrapButtonTouched" object:self];}
    //comment버튼을 눌렀을 경우
    else
        [[NSNotificationCenter defaultCenter]postNotificationName:@"timelineCommentButtonTouched" object:self];
}

-(int)getStatus{
    return status;
}

-(void)setStatus:(int)newStatus{
    status = newStatus;
    [self setImage:[UIImage imageNamed:[buttonName objectAtIndex:status]] forState:UIControlStateNormal];
}

-(NSArray *)getButtonName{
    return buttonName;
}


@end
