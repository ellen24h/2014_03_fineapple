//
//  MyLibraryReadBookCell.m
//  NEXT_Library
//
//  Created by nhnext on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "MyLibraryReadBookCell.h"

@implementation MyLibraryReadBookCell
{

    UIImageView *imageView;
}
- (id)initWithFrame:(CGRect)aRect
{
    if ((self = [super initWithFrame:aRect])) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 190)];
        [self addSubview:imageView];
        
    }
    return self;
}



- (void) setImage: (UIImage*) img
{
    [imageView setImage: img];
}



@end
