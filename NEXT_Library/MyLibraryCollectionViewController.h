//
//  MyLibraryCollectionViewController.h
//  NEXT_Library
//
//  Created by nhnext on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicSetting.h"

@interface MyLibraryCollectionViewController : UICollectionViewController
{
@public
    BOOL readSelected;
    BOOL wishSelected;
    UIButton *readButton;
    UIButton *wishButton;
}

@end
