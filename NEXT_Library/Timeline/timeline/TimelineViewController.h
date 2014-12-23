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

#define NAMELABEL_HEIGHT 20
#define NAMELABEL_TAG 100
#define LIKEICON_TAG 101
#define SCRAPICON_TAG 102
#define COMMENTICON_TAG 103
#define CELL_HEIGHT 400
#define ICON_SIZE 15
#define WHITE_OPACITY 0.9
#define POST_RANGE {0,47}

#define TIMELINE 0
#define MYPOST 1

//colors : RGBValue
#define FINE_GREEN 0x19BDC4
#define FINE_BEIGE 0xFFF6EE
#define FINE_DARKGRAY 0x4D4D4D

#define NAVERBOOKS_URL @"http://openapi.naver.com/search"
@interface TimelineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    @private
    NSArray * timelineJsonData;
    NSDictionary * timelineRowData;
    NSInteger numOfRow;
    NSInteger focusedTab;
    TimelineModel * model;
}

@property (weak, nonatomic) IBOutlet TimelineTableView *timelineTableView;
@property (weak, nonatomic) IBOutlet timelineTabButton * timelineButton;
@property (weak, nonatomic) IBOutlet timelineTabButton * mypostButton;

@end
