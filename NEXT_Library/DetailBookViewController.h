//
//  DetailBookViewController.h
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 28..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailModel.h"
#import "UIImageView+WebCache.h"

@interface DetailBookViewController : UIViewController {
    BookDetailModel * model;
    NSString * read_Count;
    NSString * wish_Count;

}
@property (nonatomic) NSString *isbnFromOtherView;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *bookImg;
@property (weak, nonatomic) IBOutlet UIButton *readBook;
@property (weak, nonatomic) IBOutlet UIButton *wishBook;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *publish_year;
@property (weak, nonatomic) IBOutlet UILabel *large_ctag;
@property (weak, nonatomic) IBOutlet UILabel *medium_ctag;
@property (weak, nonatomic) IBOutlet UILabel *small_ctag;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *book_intro;
@property (weak, nonatomic) IBOutlet UILabel *count_read;
@property (weak, nonatomic) IBOutlet UILabel *count_wish;

@end
