//
//  serachResultBookButton.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 28..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "serachResultBookButton.h"

@implementation serachResultBookButton
-(id)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        [self addTarget:self action:@selector(touched) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)setProperty:(NSString *)titleArg bookImg:(NSString *)imgArg bookAuthor:(NSString *)authorArg bookIsbn:(NSString *)isbnArg{
    self->bookTitle = titleArg;
    self->bookImg = imgArg;
    self->bookAuthor = authorArg;
    self->bookIsbn = isbnArg;
}
-(void)touched{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"bookSelected" object:self];
}

@end
