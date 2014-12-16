//
//  SetBookFirstTableViewController.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 15..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "SetBookFirstTableViewController.h"
#import "NXBookDataModel.h"
#import "BookTableViewCell.h"

@interface SetBookFirstTableViewController () {
    NSMutableArray *myObject;
    // A dictionary object
    NSDictionary *dictionary;
    // Define keys
    NSString *title;
    NSString *thumbnail;
    NSString *author;
    NSString *permalink;
}

@end

@implementation SetBookFirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    title = @"title";
    thumbnail = @"thumbnail";
    author = @"author";
    permalink = @"permalink";
    
    myObject = [[NSMutableArray alloc] init];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:@"http://gooruism.com/feed/json"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *title_data = [dataDict objectForKey:@"title"];
        NSString *thumbnail_data = [dataDict objectForKey:@"thumbnail"];
        NSString *author_data = [dataDict objectForKey:@"author"];
        NSString *permalink_data = [dataDict objectForKey:@"permalink"];
        
        NSLog(@"TITLE: %@",title_data);
        NSLog(@"THUMBNAIL: %@",thumbnail_data);
        NSLog(@"AUTHOR: %@",author_data);
        NSLog(@"URL: %@",permalink_data);
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      title_data, title,
                      thumbnail_data, thumbnail,
                      author_data,author,
                      permalink_data,permalink,
                      nil];
        [myObject addObject:dictionary];
    }
    //self.letterData = [@[@"A",@"B",@"C",@"D",@"E"] mutableCopy];
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
    return myObject.count;
}


- (BookTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"bookCell";
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[BookTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *text;
    //text = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:title]];
    text = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKeyedSubscript:title]];
    
    NSMutableString *detail;
    detail = [NSMutableString stringWithFormat:@"Author: %@ ",
              [tmpDict objectForKey:author]];
    
    NSMutableString *images;
    images = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:thumbnail]];
    
    NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:thumbnail]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    
    cell.bookTitle.text = text;
    cell.bookWriter.text = detail;
    cell.bookImg.frame = CGRectMake(0,0,80,70);
    cell.bookImg.image = img;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 151;
}

@end