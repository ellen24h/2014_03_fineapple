//
//  timelineButton.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 20..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#define INACTIVE 0
#define ACTIVE 1


@interface timelineButton : UIButton
{
@private
    int status;
    NSArray * buttonName;
}
-(id)initWithButtonName:(NSString *)inactiveButtonImg activeButtonImg:(NSString *)activeButtonImg;
-(void)touched;
-(int)getStatus;
-(void)setStatus:(int)status;
-(NSArray *)getButtonName;
@end
