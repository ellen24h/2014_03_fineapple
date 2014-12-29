//
//  serachResultBookButton.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 28..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface serachResultBookButton : UIButton
{
@public
    NSString * bookTitle;
    NSString * bookImg;
    NSString * bookAuthor;
    NSString * bookIsbn;
}

-(id)initWithFrame:(CGRect)frame;
-(void)setProperty:(NSString *)titleArg bookImg:(NSString *)imgArg bookAuthor:(NSString *)authorArg bookIsbn:(NSString *)isbnArg;
-(void)touched;
@end
