//
//  InitProfileViewController.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 2..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "InitProfileViewController.h"

@interface InitProfileViewController ()
{@private
    int attendOrNotIdx;
    int semesterNumIdx;
    int majorFirstIdx;
    int majorSecondIdx;
}
@property (weak, nonatomic) IBOutlet UILabel *attendOrNot;
@property (weak, nonatomic) IBOutlet UILabel *semesterNum;
@property (weak, nonatomic) IBOutlet UILabel *majorFirst;
@property (weak, nonatomic) IBOutlet UILabel *majorSecond;
@property (nonatomic, strong) NSMutableArray *attendOrNotArray;
@property (nonatomic, strong) NSMutableArray *semesterNumArray;
@property (nonatomic, strong) NSMutableArray *majorArray;
@end

@implementation InitProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    attendOrNotIdx = 0;
    semesterNumIdx = 0;
    majorFirstIdx = 0;
    majorSecondIdx = 6;
    
    self.attendOrNotArray = [[NSMutableArray alloc]init];
    [self.attendOrNotArray addObject:@"재학생"];
    [self.attendOrNotArray addObject:@"휴학생"];
    _attendOrNot.text = [self.attendOrNotArray objectAtIndex:0];
    
    self.semesterNumArray = [[NSMutableArray alloc]init];
    [self.semesterNumArray addObject:@"1"];
    [self.semesterNumArray addObject:@"2"];
    [self.semesterNumArray addObject:@"3"];
    [self.semesterNumArray addObject:@"4"];
    [self.semesterNumArray addObject:@"5"];
    [self.semesterNumArray addObject:@"6"];
    [self.semesterNumArray addObject:@"OVER 6"];
    _semesterNum.text = [self.semesterNumArray objectAtIndex:0];
    
    self.majorArray = [[NSMutableArray alloc]init];
    [self.majorArray addObject:@"iOS"];
    [self.majorArray addObject:@"Android"];
    [self.majorArray addObject:@"Web UI"];
    [self.majorArray addObject:@"Web Server"];
    [self.majorArray addObject:@"Game Client"];
    [self.majorArray addObject:@"Game Server"];
    [self.majorArray addObject:@"널 값"];
    _majorFirst.text = [self.majorArray objectAtIndex:0];
    _majorSecond.text = [self.majorArray objectAtIndex:6];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 이벤트핸들러: 좌우 버튼 클릭시
- (IBAction)attendOrNotLeftButton:(id)sender {
    attendOrNotIdx--;
    if (attendOrNotIdx < 0) {
        attendOrNotIdx = self.attendOrNotArray.count - 1;
    };
    _attendOrNot.text = [self.attendOrNotArray objectAtIndex:attendOrNotIdx];
}
- (IBAction)attendOrNotRightButton:(id)sender {
    attendOrNotIdx++;
    attendOrNotIdx = attendOrNotIdx % self.attendOrNotArray.count;
    _attendOrNot.text = [self.attendOrNotArray objectAtIndex:attendOrNotIdx];
}
- (IBAction)semesterNumLeftButton:(id)sender {
    semesterNumIdx--;
    if (semesterNumIdx < 0) {
        semesterNumIdx = self.semesterNumArray.count - 1;
    };
    _semesterNum.text = [self.semesterNumArray objectAtIndex:semesterNumIdx];
}
- (IBAction)semesterNumRightButton:(id)sender {
    semesterNumIdx++;
    semesterNumIdx = semesterNumIdx % self.semesterNumArray.count;
    _semesterNum.text = [self.semesterNumArray objectAtIndex:semesterNumIdx];
}
- (IBAction)majorFirstLeftButton:(id)sender {
    majorFirstIdx--;
    if (majorFirstIdx < 0) {
        majorFirstIdx = self.majorArray.count - 1;
    };
    _majorFirst.text = [self.majorArray objectAtIndex:majorFirstIdx];
}
- (IBAction)majorFirstRightButton:(id)sender {
    majorFirstIdx++;
    majorFirstIdx = majorFirstIdx % self.majorArray.count;
    _majorFirst.text = [self.majorArray objectAtIndex:majorFirstIdx];
}
- (IBAction)majorSecondLeftButton:(id)sender {
    majorSecondIdx--;
    if (majorSecondIdx < 0) {
        majorSecondIdx = self.majorArray.count - 1;
    };
    _majorSecond.text = [self.majorArray objectAtIndex:majorSecondIdx];
}
- (IBAction)majorSecondRightButton:(id)sender {
    majorSecondIdx++;
    majorSecondIdx = majorSecondIdx % self.majorArray.count;
    _majorSecond.text = [self.majorArray objectAtIndex:majorSecondIdx];
}
- (IBAction)initProfileSend:(id)sender {
    //NSURLRequest 만들기
    NSString * URLString = @"http://10.73.45.55:5000/initProfile";
    NSString * FormData = [NSString stringWithFormat:@"attendOrNot=%@&semesterNum=%@&majorFirst=%@&majorSecond=%@", _attendOrNot,_semesterNum,_majorFirst,_majorSecond];
    NSURL * url = [NSURL URLWithString:URLString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[FormData dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSURLConnection 으로 Request 전송
    NSHTTPURLResponse * sResponse;
    NSError * error;
    NSData * resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&sResponse error:&error];
    
}
@end