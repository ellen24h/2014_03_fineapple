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

- (void)viewDidLoad {
    [super viewDidLoad];
    // 스크롤 설정
    [self.scroll setScrollEnabled:YES];
    [self.scroll setContentSize:CGSizeMake(320, 1030)];
    NSString * ISBN = @"9788982814471";
    //model 생성
    model = [BookDetailModel sharedTimelineModel];
    [model getDetailData:ISBN];
    read_Count = [model readCount:@"9788982814471"];
    wish_Count = [model wishCount:@"9788982814471"];
    
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
