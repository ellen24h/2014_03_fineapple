//
//  NXBookDataModel.h
//  NEXT_Library
//
//  Created by 차용빈 on 2014. 12. 15..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "publicSetting.h"

@class Book;

@interface NXBookDataModel : NSObject

@property (nonatomic, copy) NSString *bookTitle;
@property (nonatomic, copy) NSString *bookAuthor;
@property (nonatomic, copy) NSString *imgPath;
@property (nonatomic, readonly) NSMutableArray *bookList; // 테스트용 배열

- (NSUInteger)bookCount;
- (Book *)bookAtIndex: (NSUInteger)index;
- (void) initializeDefaultBook;

@end
