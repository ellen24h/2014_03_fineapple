//
//  SettingViewController.h
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingModel.h"

@interface SettingViewController : UIViewController
{
@private

}
@property (weak, nonatomic) IBOutlet UILabel *wishCount;
@property (weak, nonatomic) IBOutlet UILabel *readCount;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@end
