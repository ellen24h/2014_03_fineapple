//
//  SearchNavController.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 16..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "SearchNavController.h"

@interface SearchNavController ()

@end

@implementation SearchNavController

- (NSMutableArray *) array {
    if(!_array) {
        _array = [[NSMutableArray alloc] init];
    }
    return _array;
}

- (NSMutableArray *)searchResults {
    if(!_searchResults) {
        _searchResults = [[NSMutableArray alloc] init];
    }
    return _searchResults;
}

- (void)viewDidLoad {
    self.array = [NSMutableArray arrayWithCapacity:[self.array count]]; // 최근 검색 목록으로 할까?
    self.searchResults = [[NSMutableArray alloc] init]; // 검색어에 따라 필터링된 책 목록.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Table View 함수들.

- (void)keyboardShown:(NSNotification *)note {
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    CGRect frame = self.tableView.frame;
    frame.size.height -= keyboardFrame.size.height;
    [self.tableView setFrame:frame];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    return [self.array count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    else {
        return [self.array count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"bookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    }
    return cell;
}

// Book Search 함수들.

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    self.searchResults = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
    self.searchResults = [[self.array filteredArrayUsingPredicate:predicate] mutableCopy];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return true;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchText length] == 0) {
        [self.searchResults removeAllObjects];
        [self.searchResults addObjectsFromArray:self.array];
    }
    else {
        [self.searchResults removeAllObjects];
        for(NSString *string in self.array) {
            NSRange range = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(range.location != NSNotFound) {
                [self.searchResults addObject:string];
            }
        }
    }
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@""]) {
        NSString *object = nil;
        NSIndexPath *indexPath = nil;
        if(self.searchDisplayController.isActive) {
            indexPath = [self.tableView indexPathForSelectedRow];
            object = self.searchResults[indexPath.row];
        }
    }
}

@end