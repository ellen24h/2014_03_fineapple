//
//  DetailBookViewController.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 28..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "DetailBookViewController.h"

@interface DetailBookViewController ()

@end

@implementation DetailBookViewController
-(void)viewDidLayoutSubviews{
    [_scroll setScrollEnabled:YES];
    [_scroll setContentSize:CGSizeMake(320, 1030)];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 스크롤 설정
    [_scroll setScrollEnabled:YES];
    [_scroll setContentSize:CGSizeMake(320, 1030)];
    NSLog(@"%f",_scroll.frame.size.height);
    NSString * ISBN = _isbnFromOtherView;
    //model 생성
    model = [BookDetailModel sharedTimelineModel];
    [model getDetailData:ISBN];
    read_Count = [model readCount:ISBN];
    wish_Count = [model wishCount:ISBN];
    
    NSDictionary * bookDict = [model.myObject objectAtIndex:0];
    self.bookName.text = [NSMutableString stringWithFormat:@"%@",
                          [bookDict objectForKey:@"name"]];
    self.bookAuthor.text = [NSMutableString stringWithFormat:@"%@",
                          [bookDict objectForKey:@"author"]];
    self.publish_year.text = [NSMutableString stringWithFormat:@"%@",
                          [bookDict objectForKey:@"publish_year"]];
    self.large_ctag.text = [NSMutableString stringWithFormat:@"%@",
                              [bookDict objectForKey:@"large_ctag"]];
    self.medium_ctag.text = [NSMutableString stringWithFormat:@"%@",
                            [bookDict objectForKey:@"medium_ctag"]];
    self.small_ctag.text = [NSMutableString stringWithFormat:@"%@",
                             [bookDict objectForKey:@"small_ctag"]];
    self.location.text = [NSMutableString stringWithFormat:@"%@",
                            [bookDict objectForKey:@"location1"]];
    NSURL *url = [NSURL URLWithString:[bookDict objectForKey:@"cover_img"]];
    
    [self.bookImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"sample_book_img"]];
    
    self.count_read.text = read_Count;
    self.count_wish.text = wish_Count;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
