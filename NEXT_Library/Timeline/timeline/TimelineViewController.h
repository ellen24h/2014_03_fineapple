//
//  TimelineViewController.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 19..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicSetting.h"
#import "timelineButton.h"
#import "timelineTabButton.h"
#import "TimelineModel.h"
#import "TimelineTabController.h"
#import "TimelineTableView.h"
#import "bookTitleButton.h"
#import "DetailBookViewController.h"

#define NAMELABEL_HEIGHT 20
#define NAMELABEL_TAG 100
#define ADDTIONALINFO_TAG 11
#define CELL_HEIGHT 400
#define ICON_SIZE 15
#define WHITE_OPACITY 0.9
#define POST_RANGE {0,47}

#define TIMELINE 0
#define MYPOST 1

#define COMMENT_BACKVIEW_TAG 901
#define COMMENT_TEXTVIEW_TAG 902

#define NAVERBOOKS_URL @"http://openapi.naver.com/search"
@interface TimelineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    @private
    NSArray * timelineJsonData;
    NSDictionary * timelineRowData;
    NSDictionary * likeData;
    NSInteger numOfRow;
    NSInteger focusedTab;
    TimelineModel * model;
}

@property (weak, nonatomic) IBOutlet TimelineTableView *timelineTableView;
@property (weak, nonatomic) IBOutlet timelineTabButton * timelineButton;
@property (weak, nonatomic) IBOutlet timelineTabButton * mypostButton;
@property (weak, nonatomic) IBOutlet UIButton *addPostingButton;

@end
