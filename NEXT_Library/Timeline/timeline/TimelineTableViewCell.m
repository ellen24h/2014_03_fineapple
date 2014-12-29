//
//  TimelineTableView.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 20..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "TimelineTableViewCell.h"

@implementation TimelineTableViewCell


//Cell이 선택 되었을 때 subview들이 사라지는 것을 방지하기 위해
//setHighlighted, setSelected method override
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor *backgroundColor = self.backgroundColor;
    self.backgroundColor = backgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    UIColor *backgroundColor = self.backgroundColor;
    self.backgroundColor = backgroundColor;
}

@end
