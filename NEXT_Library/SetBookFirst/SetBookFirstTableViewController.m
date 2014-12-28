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
    // model 객체 생성
    model = [NXBookDataModel sharedTimelineModel];
    [model getBookData];
    [_tableData reloadData];
    // 데이터 모델에서 값을 전달 받음.
    myObject = [model returnMutableArray];
    
    setRead = [[NSMutableSet alloc] init];
    setWish = [[NSMutableSet alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [model bookCount];
}

// 테이블에 보여지는 것들.
- (BookTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 초기 cell 설정.
    static NSString *cellIdentifier = @"bookCell";
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[BookTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // 데이터 모델에서 값을 전달 받음.
    //NSMutableArray * myObject = [model returnMutableArray];
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    //책 이름에 대하여...
    NSMutableString *name;
    name = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKeyedSubscript:@"name"]];
    
    //책 작가에 대하여...
    NSMutableString *author;
    author = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:@"author"]];
    
    //책 이미지에 대하여...
    NSMutableString *cover_img;
    cover_img = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:@"cover_img"]];
/*
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
*/
    // 위 (주석) 코드를 보기 좋게 한 줄로.
    // 책 이미지 경로 받은 것을 NSURL로..
    NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:@"cover_img"]];
    
    // cell에 뿌려주는 작업.
    cell.view.backgroundColor = [UIColor whiteColor];
    cell.bookTitle.text = name;
    cell.bookWriter.text = author;
    cell.bookImg.frame = CGRectMake(0,0,80,70);
    cell.readBook.tag = indexPath.row;
    cell.wishBook.tag = indexPath.row;
    //cell.bookImg.image = img;
    //위 방식으로 이미지를 보여준다면.. 이미지 데이터를 전부 받아 오는데 까지 테이블 셀을 만들지 않음.
    //SDWebImage Lib(?)을 이용.
    [cell.bookImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Null"]];
    cell.bookImg.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}

//테이블의 셀의 높이를 지정함.
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 151;
}

//read button을 touch하면 나타나는 Action
- (IBAction)action_read:(id)sender {
    UIButton * read_Button = sender;
    if (read_Button.selected == NO){
        read_Button.selected = YES;
        NSNumber * readTag = [NSNumber numberWithLong:[read_Button tag]];
        NSLog(@"%@",readTag);
        [setRead addObject:readTag];
        NSLog(@"%@", setRead);
    } else {
        read_Button.selected = NO;
    }
}

- (IBAction)Done:(id)sender {
}


//wish button을 touch하면 나타나는 Action
- (IBAction)action_wish:(id)sender {
    UIButton * wish_Button = sender;
    if (wish_Button.selected == NO) {
        wish_Button.selected = YES;
        NSNumber * wishTag = [NSNumber numberWithLong:[wish_Button tag]];
        [setWish addObject:wishTag];
    } else {
        wish_Button.selected = NO;
    }
}


- (IBAction)doneButtonTouch:(id)sender {
    [LoadScene loadSceneByPush:self loadSceneName:@"MainTab"];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float height = scrollView.frame.size.height;
    float contentsHeight = scrollView.contentSize.height;
    float scrollSet = scrollView.contentOffset.y;
    
    if (scrollSet + height == contentsHeight) {
        NXBookDataModel * remodel = [NXBookDataModel sharedTimelineModel];
        [remodel getBookData];
        [_tableData reloadData];
    }
}

@end