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
    self.array = [NSMutableArray arrayWithCapacity:[self.array count]];
    self.searchResults = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    _searchBar.delegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bookDataLoadDone:) name:@"bookDataLoadDone" object:nil];
}

-(void)bookDataLoadDone:(NSNotification *)noti{
    NSDictionary * data = noti.object;
    bookDataDic = data;
    bookDataArr = [[NSArray alloc] initWithArray:[[bookDataDic objectForKey:@"channel"]objectForKey:@"item"]];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// Table View 함수들.

- (void)keyboardShown:(NSNotification *)note {
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    CGRect frame = self.tableView.frame;
    frame.size.height -= keyboardFrame.size.height;
    [self.tableView setFrame:frame];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[bookDataDic objectForKey:@"channel"]objectForKey:@"result"] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger rowNum = indexPath.row;
    static NSString *cellID = @"bookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    NSString * bookTitle = [[[bookDataArr objectAtIndex:rowNum] objectForKey:@"title"] stringByReplacingOccurrencesOfString:@"&lt;b&gt;" withString:@""];
    NSString * bookIsbn = [[bookDataArr objectAtIndex:rowNum] objectForKey:@"isbn"];
    bookTitle = [bookTitle stringByReplacingOccurrencesOfString:@"&lt;/b&gt;" withString:@""];
    cell.textLabel.text = bookTitle;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"ISBN : %@",bookIsbn];
    

    return cell;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    self.searchResults = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
    self.searchResults = [[self.array filteredArrayUsingPredicate:predicate] mutableCopy];
}

- (NSDictionary *)parseJsonResponse:(NSString *)searchText {
    NSURLResponse *response;
    NSData * data;
    NSString *urlString = [NSString stringWithFormat:@"http://apis.daum.net/search/book?q=%@&apikey=ae04be3ff84bfb7d678768b3270dbd5d63741b41&output=json", searchText];
    NSLog(@"%@", urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSError *error;
    NSDictionary *dic;
    dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return dic;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return true;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString *searchTextTmp = [searchText stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"%@", searchTextTmp);
    NSDictionary *dic = [self parseJsonResponse:searchTextTmp];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bookDataLoadDone" object:dic];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toBookDetail"])
    {
        NSLog(@"잘뜸");
        NSLog(@"sender : %@",sender);
        DetailBookViewController *vc = [segue destinationViewController];
        UITableViewCell * cell = sender;
        NSLog(@"%@",cell.detailTextLabel.text);
        vc.isbnFromOtherView =cell.detailTextLabel.text;
    }
}


@end