//
//  MyLibarayPushButtonCell.m
//  NEXT_Library
//
//  Created by nhnext on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "MyLibarayPlusButtonCell.h"

@implementation MyLibarayPushButtonCell
{
        UIButton *button;
}

- (id)initWithFrame:(CGRect)aRect
{
    if ((self = [super initWithFrame:aRect])) {
        
        button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 190)];
        
        [self addSubview:button];
    }
    return self;
}

-(void) setTitle:(NSString*) title
{
    [button setTitle:title forState:UIControlStateNormal];
}
- (void) addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [button addTarget:target action:action forControlEvents:controlEvents];
}
@end
