//
//  NXBookDataModel.m
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 15..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "NXBookDataModel.h"
#import <ImageIO/CGImageSource.h>

@interface NXBookDataModel()

@end

@implementation NXBookDataModel

-(id)init {
    self = [super init];
    
    if (self) {
        _bookTitle = self.bookTitle;
        _bookAuthor = self.bookAuthor;
        _imgPath = self.imgPath;
        _bookList = [[NSMutableArray alloc] init];
        [self initializeDefaultBook];
        return self;
    }
    return nil;
}

@end