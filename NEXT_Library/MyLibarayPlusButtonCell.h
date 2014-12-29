//
//  MyLibarayPushButtonCell.h
//  NEXT_Library
//
//  Created by nhnext on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLibarayPushButtonCell : UICollectionViewCell
-(void) setTitle:(NSString*) title;
- (void) addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
