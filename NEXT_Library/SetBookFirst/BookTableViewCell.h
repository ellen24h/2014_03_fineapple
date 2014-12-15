//
//  BookTableViewCell.h
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 15..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookImg;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookWriter;
@property (weak, nonatomic) IBOutlet UIButton *readBook;
@property (weak, nonatomic) IBOutlet UIButton *wishBook;

@end
 