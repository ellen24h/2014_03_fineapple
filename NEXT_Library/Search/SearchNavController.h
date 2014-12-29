//
//  SearchNavController.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 16..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailBookViewController.h"

@interface SearchNavController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate, NSURLConnectionDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSMutableData *responseData;
    NSDictionary * bookDataDic;
    NSArray * bookDataArr;
}

@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableArray *keys;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end