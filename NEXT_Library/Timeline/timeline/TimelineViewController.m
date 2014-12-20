//
//  TimelineViewController.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 19..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "TimelineViewController.h"

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TimelineModel * model =[[TimelineModel alloc]initWithURLWithPortNum:[publicSetting getServerAddr] port:[publicSetting getPortNum]];
    NSNotificationCenter * notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(setJsonDataAsClassVariable:) name:@"timelineJsonReceived" object:nil];
    self.tabBarController.tabBar.frame = CGRectMake(0,0,0,0);
    _timelineTableView.backgroundColor = UIColorFromRGB(FINE_BEIGE);
    [publicSetting setLoadingAnimation:self];
    [model getTimelineJsonFromServer];
   

}


- (void)setJsonDataAsClassVariable:(NSNotification *)notification{
    timelineJsonData = notification.object;
    numOfRow = timelineJsonData.count;
    _timelineTableView.dataSource = self;
    [publicSetting removeLoadingAnimation:self];
    [_timelineTableView reloadData];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return numOfRow;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorColor = [UIColor clearColor];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"post"];
    cell.backgroundColor = UIColorFromRGB(FINE_BEIGE);
    
    UIView * postContentView = [self setPostContentView:tableView cell:cell];
    [self setBackgroundImage:postContentView indexPath:indexPath];
    UILabel * nameLabel = [self setNameLabel:postContentView indexPath:indexPath];
    [self setAdditionalInfo:nameLabel indexPath:indexPath];
    [self setBookTitle:postContentView indexPath:indexPath];
    [self setPostWithComment:postContentView indexPath:indexPath];
    [self setButtons:postContentView indexPath:indexPath];

    return cell;
}

-(void)setButtons:(UIView *)postContentView indexPath:(NSIndexPath *)indexPath{
    CGFloat fullWidth = postContentView.frame.size.width;
    CGFloat fullHeight = postContentView.frame.size.height;
    UIView * buttonSet = [[UIView alloc]initWithFrame:CGRectMake(0, fullHeight*0.9, fullWidth, fullHeight*0.1)];
    buttonSet.backgroundColor = UIColorFromRGB(FINE_GREEN);
    [postContentView addSubview:buttonSet];
    
    UIButton * likeButton = [[timelineButton alloc]initWithButtonName:@"like_inactive" activeButtonImg:@"like_active"];
    likeButton.frame = CGRectMake(5, buttonSet.frame.size.height*0.23, fullWidth*0.25, buttonSet.frame.size.height*0.53);
    [buttonSet addSubview:likeButton];
    
    UIButton * scrapButton = [[timelineButton alloc]initWithButtonName:@"scrap_inactive" activeButtonImg:@"scrap_active"];
    scrapButton.frame = CGRectMake(fullWidth*0.355, buttonSet.frame.size.height*0.24, fullWidth*0.25, buttonSet.frame.size.height*0.53);
    [buttonSet addSubview:scrapButton];
    
    UIButton * commentButton = [[timelineButton alloc]initWithButtonName:@"comment_inactive" activeButtonImg:@"comment_active"];
    commentButton.frame =  CGRectMake(fullWidth*0.70, buttonSet.frame.size.height*0.24, fullWidth*0.25, buttonSet.frame.size.height*0.53);
    [buttonSet addSubview:commentButton];

}

-(void)setPostWithComment:(UIView *)postContentView indexPath:(NSIndexPath *)indexPath{
    timelineRowData = [timelineJsonData objectAtIndex:indexPath.row];
    NSString * postString = [timelineRowData objectForKey:@"post"];
    NSString * commentString = [timelineRowData objectForKey:@"comment1"];
    NSString * commentUser = [timelineRowData objectForKey:@"comment1userName"];
    NSRange postRange;
    NSRange commentRange;
    if(postString.length >= 47){
        postRange.location = 0;
        postRange.length = 47;
    }
    else{
        postRange.location = 0;
        postRange.length = postString.length-1;
    }
    if(commentString.length >= 35){
        commentRange.location = 0;
        commentRange.length = 35;
    }
    else{
        commentRange.location = 0;
        commentRange.length = commentString.length-1;
    }
    


    
    CGFloat fullWidth = postContentView.frame.size.width;
    CGFloat fullHeight = postContentView.frame.size.height;
    
    UITextView * postText = [[UITextView alloc]initWithFrame:CGRectMake(6, 0, fullWidth, fullHeight*0.4*0.5)];
    postText.scrollEnabled = NO;
    postText.editable = NO;
    postText.text = [NSString stringWithFormat:@"%@",[postString substringWithRange:postRange]];
    postText.textAlignment = NSTextAlignmentLeft;
    postText.font = [UIFont fontWithName:@"Helvetica" size:17];
    postText.textColor = UIColorFromRGB(FINE_DARKGRAY);
    postText.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    
    UIButton * moreButton = [[UIButton alloc]initWithFrame:CGRectMake(fullWidth*0.73, postText.frame.size.height*0.7, fullWidth * 0.2, 14)];
    [moreButton setTitle:@"더읽기" forState:UIControlStateNormal];
    [moreButton setTitleColor:UIColorFromRGB(FINE_GREEN) forState:UIControlStateNormal];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    moreButton.showsTouchWhenHighlighted = YES;
    [postText addSubview:moreButton];
    
    UITextView * commentText = [[UITextView alloc]initWithFrame:CGRectMake(fullWidth * 0.22, fullHeight*0.4*0.5, fullWidth*0.8, fullHeight*0.4*0.5)];
    commentText.scrollEnabled = NO;
    commentText.editable = NO;
    commentText.text = [NSString stringWithFormat:@"%@",[commentString substringWithRange:commentRange]];
    commentText.textAlignment = NSTextAlignmentLeft;
    commentText.font = [UIFont fontWithName:@"Helvetica" size:17];
    commentText.textColor = UIColorFromRGB(FINE_DARKGRAY);
    commentText.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
   
    
    UIButton * commentUserButton = [[UIButton alloc]initWithFrame:CGRectMake(8, fullHeight*0.4*0.5+10, fullWidth*0.2, 17)];
    [commentUserButton setTitle:commentUser forState:UIControlStateNormal];
    [commentUserButton setTitleColor:UIColorFromRGB(FINE_DARKGRAY) forState:UIControlStateNormal];
    commentUserButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    commentUserButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    commentUserButton.showsTouchWhenHighlighted = YES;
    
        
    UIButton * commentMoreButton = [[UIButton alloc]initWithFrame:CGRectMake(fullWidth*0.43, commentText.frame.size.height*0.7, fullWidth * 0.3, 14)];    [commentMoreButton setTitle:@"댓글더보기" forState:UIControlStateNormal];
    [commentMoreButton setTitleColor:UIColorFromRGB(FINE_GREEN) forState:UIControlStateNormal];
    commentMoreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    commentMoreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    commentMoreButton.showsTouchWhenHighlighted = YES;
    [commentText addSubview:commentMoreButton];
   

    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(fullWidth*0.025, fullHeight*0.4*0.5, fullWidth*0.95, 0.2)];
    line.backgroundColor = UIColorFromRGB(FINE_DARKGRAY);



    UIView * postWithComment = [[UIView alloc]initWithFrame:CGRectMake(0, fullHeight*0.5, fullWidth ,  fullHeight*0.4)];
    postWithComment.backgroundColor = [UIColor colorWithWhite:1.0 alpha:WHITE_OPACITY];
    [postWithComment addSubview:postText];
    if([commentUser isEqualToString:@"\\N"] != YES){
        [postWithComment addSubview:commentUserButton];
        [postWithComment addSubview:commentText];
    }
    [postWithComment addSubview:line];
   
    
    [postContentView addSubview:postWithComment];
    
    
}

-(UIView *)setPostContentView:(UITableView * )tableView cell:(UITableViewCell *)cell{
    UIView * postContentView = [[UIView alloc]initWithFrame:CGRectMake(tableView.frame.size.width * 0.05, tableView.frame.size.width * 0.05, tableView.frame.size.width * 0.9, CELL_HEIGHT - tableView.frame.size.width * 0.1)];
    [cell.contentView addSubview:postContentView];
    return postContentView;
}

-(NSString *)getBookTitleFromNaverBooks:(NSString *)ISBN{
    NSString * key = [publicSetting getNaverBooksKey];
    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@?key=%@&query=abc&target=book_adv&d_isbn=%@",NAVERBOOKS_URL,key,ISBN]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLResponse * response;
    NSData * recvData;
    recvData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString * recvData_str = [[NSString alloc]initWithData:recvData encoding:NSUTF8StringEncoding];
    if([recvData_str rangeOfString:@"<error>"].location == NSNotFound ){
    recvData_str = [[recvData_str componentsSeparatedByString:@"<item>"]objectAtIndex:1];    recvData_str = [[recvData_str componentsSeparatedByString:@"<title>"]objectAtIndex:1];
    recvData_str = [[recvData_str componentsSeparatedByString:@"</title>"]objectAtIndex:0];
    }
    else{
        recvData_str = @"Untitled";
    }
    return recvData_str;
}

-(void)setBookTitle:(UIView *)postContentView indexPath:(NSIndexPath *)indexPath{
    timelineRowData = [timelineJsonData objectAtIndex:indexPath.row];
    NSString * bookTitle = [timelineRowData objectForKey:@"bookTitle"];
    if(bookTitle == (id)[NSNull null]){
        bookTitle = [self getBookTitleFromNaverBooks:[timelineRowData objectForKey:@"ISBN"]];
    }
    UIImageView * bookIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"book_icon.png"]];
    bookIcon.frame = CGRectMake(0, NAMELABEL_HEIGHT, NAMELABEL_HEIGHT, NAMELABEL_HEIGHT);
    bookIcon.backgroundColor = [UIColor colorWithWhite:1.0 alpha:WHITE_OPACITY];
    [postContentView addSubview:bookIcon];

    UILabel * bookTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(NAMELABEL_HEIGHT,NAMELABEL_HEIGHT, postContentView.frame.size.width-NAMELABEL_HEIGHT, NAMELABEL_HEIGHT)];
    bookTitleLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:WHITE_OPACITY];
    bookTitleLabel.textColor = UIColorFromRGB(0x4D4D4D);
    bookTitleLabel.text = @"";
    [postContentView addSubview:bookTitleLabel];
    
    UIButton * bookTitleButton = [[UIButton alloc]initWithFrame:CGRectMake(NAMELABEL_HEIGHT, NAMELABEL_HEIGHT, bookTitleLabel.frame.size.width, NAMELABEL_HEIGHT)];
    [bookTitleButton setTitle:bookTitle forState:UIControlStateNormal];
    [bookTitleButton setTitleColor:UIColorFromRGB(FINE_DARKGRAY) forState:UIControlStateNormal];
    bookTitleButton.showsTouchWhenHighlighted = YES;
    [bookTitleButton addTarget:self action:@selector(bookTitleButtonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    bookTitleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [postContentView addSubview:bookTitleButton];
}

-(void)bookTitleButtonTouchUp:(UIButton *)bookTitleButton{
    //load bookDetail page
}

-(void)setBackgroundImage:(UIView *)postContentView indexPath:(NSIndexPath *)indexPath{
    timelineRowData = [timelineJsonData objectAtIndex:indexPath.row];
    NSString * bookCoverImg = [timelineRowData objectForKey:@"postImg"];

    NSURL * imgURL = [NSURL URLWithString:bookCoverImg];
    NSData * imgData = [NSData dataWithContentsOfURL:imgURL];
    UIImageView * backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:imgData]];
    backgroundImageView.frame = CGRectMake(0,0,postContentView.frame.size.width, postContentView.frame.size.height);
    [postContentView addSubview:backgroundImageView];
}

-(void)setAdditionalInfo:(UILabel *)nameLabel indexPath:(NSIndexPath *)indexPath{
    timelineRowData = [timelineJsonData objectAtIndex:indexPath.row];
    NSString * likeNumStr = [NSString stringWithFormat:@"%@",[timelineRowData objectForKey:@"like"]];
    NSString * scrapNumStr = [NSString stringWithFormat:@"%@",[timelineRowData objectForKey:@"scrap"]];
    NSString * commentNumStr = [NSString stringWithFormat:@"%@",[timelineRowData objectForKey:@"comment"]];
    
    UIView * additionalInfoView = [[UIView alloc]initWithFrame:CGRectMake(nameLabel.frame.size.width*0.45, 0, nameLabel.frame.size.width*0.55,nameLabel.frame.size.height)];
    additionalInfoView.backgroundColor = UIColorFromRGB(FINE_GREEN);

    UIImageView * like = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"like_icon.png"]];
    like.frame = CGRectMake(0,2.5,ICON_SIZE,ICON_SIZE);
    like.tag = LIKEICON_TAG;
    [additionalInfoView addSubview:like];
    
    UILabel * likeNum =[[UILabel alloc]initWithFrame:CGRectMake(ICON_SIZE+4, 2.5, ICON_SIZE, ICON_SIZE)];
    likeNum.text = likeNumStr;
    likeNum.textColor = [UIColor whiteColor];
    likeNum.font = [UIFont fontWithName:@"Helvetica" size:12];
        [additionalInfoView addSubview:likeNum];
    
    UIImageView * scrap = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scrap_icon.png"]];
    scrap.frame = CGRectMake(ICON_SIZE*3,2.5,ICON_SIZE,ICON_SIZE);
    scrap.tag = SCRAPICON_TAG;
    [additionalInfoView addSubview:scrap];
    
    UILabel * scrapNum =[[UILabel alloc]initWithFrame:CGRectMake(ICON_SIZE*4+4, 2.5, ICON_SIZE, ICON_SIZE)];
    scrapNum.text = scrapNumStr;
    scrapNum.textColor = [UIColor whiteColor];
    scrapNum.font = [UIFont fontWithName:@"Helvetica" size:12];
    [additionalInfoView addSubview:scrapNum];
    
    UIImageView * comment = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_icon.png"]];
    comment.frame = CGRectMake(ICON_SIZE*6,2.5,ICON_SIZE,ICON_SIZE);
    comment.tag = COMMENTICON_TAG;
    [additionalInfoView addSubview:comment];
    
    UILabel * commentNum =[[UILabel alloc]initWithFrame:CGRectMake(ICON_SIZE*7+4, 2.5, ICON_SIZE, ICON_SIZE)];
    commentNum.text = commentNumStr;
    commentNum.textColor = [UIColor whiteColor];
    commentNum.font = [UIFont fontWithName:@"Helvetica" size:12];
    [additionalInfoView addSubview:commentNum];
  
    [nameLabel addSubview:additionalInfoView];
}

-(UILabel *)setNameLabel:(UIView *)postContentView indexPath:(NSIndexPath *)indexPath{
    timelineRowData = [timelineJsonData objectAtIndex:indexPath.row];
    NSString * userName = [timelineRowData objectForKey:@"name"];
    UIImageView * userIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_icon.png"]];
    userIcon.frame = CGRectMake(0, 0, NAMELABEL_HEIGHT, NAMELABEL_HEIGHT);
    userIcon.backgroundColor = UIColorFromRGB(FINE_GREEN);
    [postContentView addSubview:userIcon];

    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(NAMELABEL_HEIGHT, 0, postContentView.frame.size.width - NAMELABEL_HEIGHT, NAMELABEL_HEIGHT)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.backgroundColor = UIColorFromRGB(FINE_GREEN);
    nameLabel.text = @"";
    nameLabel.tag = NAMELABEL_TAG;
    [postContentView addSubview:nameLabel];

    UIButton * nameButton = [[UIButton alloc]initWithFrame:CGRectMake(NAMELABEL_HEIGHT, 0, nameLabel.frame.size.width*0.2, NAMELABEL_HEIGHT)];
    [nameButton setTitle:userName forState:UIControlStateNormal];    [nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nameButton.showsTouchWhenHighlighted = YES;
    nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [nameButton addTarget:self action:@selector(nameButtonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    [postContentView addSubview:nameButton];

    return nameLabel;
    
}

- (void)nameButtonTouchUp:(UIButton *)nameButton{
    //load userdetail page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
