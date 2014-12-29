//
//  PostingViewController.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 16..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "postingModel.h"
#import "serachResultBookButton.h"
#import "TimelineModel.h"
#define title 0
#define img 1
#define author 2
#define isbn 3
#define searchResultViewTag 201

@interface PostingViewController : UIViewController
{
@private
    postingModel * model;
    NSString * selectBookIsbn;
    NSString * selectBookImg;
@public
    BOOL isViewPosUp;
}

@property (weak, nonatomic) IBOutlet UIScrollView *postingScrollview;
@property (weak, nonatomic) IBOutlet UITextField *searchBarTextField;
@property (weak, nonatomic) IBOutlet UIView *selectBookView;
@property (weak, nonatomic) IBOutlet UITextView *selectBookTitle;
@property (weak, nonatomic) IBOutlet UITextView *selectBookAuthor;
@property (weak, nonatomic) IBOutlet UIImageView *selectBookImg;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextView *postText;
@property (weak, nonatomic) IBOutlet UIButton *allCancelButton;

@end
