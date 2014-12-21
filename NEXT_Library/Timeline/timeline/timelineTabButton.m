//
//  timelineTabButton.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 21..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "timelineTabButton.h"
#import "publicSetting.h"
@implementation timelineTabButton

-(void)setButtonName:(NSString *)name{
    buttonName = [[NSString alloc]initWithString:name];
}

-(void)setStatus:(int)newStatus{
    status = newStatus;
    [[NSNotificationCenter defaultCenter]postNotificationName:[NSString stringWithFormat:@"%@Touched",buttonName] object:self];
     }

-(void)setDelegate{
 [self addTarget:self action:@selector(touched) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touched{
    if (status == INACTIVE){
        status = ACTIVE;
        self.backgroundColor = UIColorFromRGB(ACTIVE_COLOR);
    }
    else{
        status = INACTIVE;
        self.backgroundColor = UIColorFromRGB(INACTIVE_COLOR);
    }
}

@end
