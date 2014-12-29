//
//  PostingScrollView.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 28..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "PostingScrollView.h"

@implementation PostingScrollView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cancelEdit" object:self];
}
@end
