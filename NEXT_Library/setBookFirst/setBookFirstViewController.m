//
//  setBookFirstViewController.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 8..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "setBookFirstViewController.h"

@interface setBookFirstViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bookImg;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UIButton *readButton;
@property (weak, nonatomic) IBOutlet UIButton *wishButton;


@end

@implementation setBookFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    setBookFirstViewController * cell = [tableView dequeueReusableCellWithIdentifier:@"bookCell" forIndexPath:indexPath];
    cell.bookName.textColor = [UIColor redColor];
    cell.bookAuthor.textColor = [UIColor blueColor];
    return cell;
}

@end