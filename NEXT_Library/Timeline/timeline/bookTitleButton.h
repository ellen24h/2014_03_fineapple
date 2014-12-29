//
//  bookTitleButton.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 30..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bookTitleButton : UIButton
{
@public
    NSString * isbn;
}
-(void)setIsbn:(NSString *)newIsbn;
@end
