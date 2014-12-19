//
//  timelineButton.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 20..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface timelineButton : UIButton
{
@private
    int status;
    NSArray * buttonName;
}
-(id)initWithButtonName:(NSString *)inactiveButtonImg activeButtonImg:(NSString *)activeButtonImg;
-(int)getStatus;
-(void)setStatus:(int)status;
@end
