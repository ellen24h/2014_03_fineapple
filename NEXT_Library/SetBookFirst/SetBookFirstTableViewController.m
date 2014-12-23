//
//  SetBookFirstTableViewController.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 15..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "SetBookFirstTableViewController.h"
#import "UIImageView+WebCache.h"


@interface SetBookFirstTableViewController ()

@end

@implementation SetBookFirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [[NXBookDataModel alloc] initWithURLwithPort:[publicSetting getServerAddr] port:[publicSetting getPortNum]];
    [model getBookData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [model bookCount];
}


- (BookTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"bookCell";
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[BookTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSMutableArray * myObject = [model returnMutableArray];
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *name;
    //text = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:title]];
    name = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKeyedSubscript:@"name"]];
    
    NSMutableString *author;
    author = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:@"author"]];
    
    NSMutableString *cover_img;
    cover_img = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:@"cover_img"]];
    
    NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:@"cover_img"]];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    //UIImage *img = [[UIImage alloc]initWithData:data];
    cell.view.backgroundColor = [UIColor whiteColor];
    cell.bookTitle.text = name;
    cell.bookWriter.text = author;
    cell.bookImg.frame = CGRectMake(0,0,80,70);
    cell.readBook.tag = indexPath.row;
    cell.wishBook.tag = indexPath.row;
    //cell.bookImg.image = img;
    
    [cell.bookImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Null"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 151;
}

- (IBAction)action_read:(id)sender {
    UIButton * read_Button = sender;
    if (read_Button.selected == NO){
        read_Button.selected = YES;
        
    } else {
        read_Button.selected = NO;
    }
}

- (IBAction)doneButtonTouch:(id)sender {
    [LoadScene loadSceneByPush:self loadSceneName:@"MainTab"];
}

@end