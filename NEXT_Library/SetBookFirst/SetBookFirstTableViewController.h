//
//  SetBookFirstTableViewController.h
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 15..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicSetting.h"
#import "NXBookDataModel.h"
#import "BookTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface SetBookFirstTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UITableView * _tableData;
    NXBookDataModel * model;
    NSMutableArray * myObject;
    NSMutableArray * arrRead;
    NSMutableArray * arrWish;
    NSMutableSet * setRead;
    NSMutableSet * setWish;
}

@property (nonatomic, strong) NSMutableArray *letterData;

@end
