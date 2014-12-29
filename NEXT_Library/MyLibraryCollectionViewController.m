//
//  MyLibraryCollectionViewController.m
//  NEXT_Library
//
//  Created by nhnext on 2014. 12. 29..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "MyLibraryCollectionViewController.h"
#import "MyLibraryReadBookCell.h"
#import "MyLibarayPlusButtonCell.h"

@interface MyLibraryCollectionViewController ()

@end

@implementation MyLibraryCollectionViewController

static NSString * const pushButton = @"Cell1";
static NSString * const bookImg= @"Cell2";
static NSString * const header = @"header";


- (void)swichReadAndWishWithNoti:(NSNotification*)noti{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[MyLibraryReadBookCell class] forCellWithReuseIdentifier:bookImg];
    [self.collectionView registerClass:[MyLibarayPushButtonCell class] forCellWithReuseIdentifier:pushButton];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myLibrary_tabtouched:) name:@"myLibrary_tabtouched" object:nil];


    
    // Do any additional setup after loading the view.
}

-(void)myLibrary_tabtouched:(NSNotification *)noti{
    if(readSelected == YES){
        readSelected = NO;
        wishSelected = YES;
        [readButton setBackgroundColor:UIColorFromRGB(0xEF4089)];
        [wishButton setBackgroundColor:UIColorFromRGB(0xB3B3B3)];
    }
    else{
        readSelected = YES;
        wishSelected = NO;
        [wishButton setBackgroundColor:UIColorFromRGB(0xEF4089)];
        [readButton setBackgroundColor:UIColorFromRGB(0xB3B3B3)];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

// 셀의 종류(카테고리 갯수): 기본값 1
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 셀의 개수: 책 권 수
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row==0){
          MyLibarayPushButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:pushButton forIndexPath:indexPath];
        [cell setTitle:@"추가하기"];
        [cell addTarget:self action:@selector(PlusButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
          MyLibraryReadBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bookImg forIndexPath:indexPath];
        [cell setImage: [UIImage imageNamed:@"frame-000000.png"]];
         return cell;
    }
    // Configure the cell
    
   
}

// PlusButtonTouch EventHandler
-(IBAction)PlusButtonTouch:(id)sender{
    NSLog(@"서치로 이동");
}

// ReadButtonTouch EventHandler
-(IBAction)readButtonTouch:(UIButton*)sender{
    if(readSelected == YES)
        [[NSNotificationCenter defaultCenter]postNotificationName:@"myLibrary_tabtouched" object:self];
}

// WishButtonTouch EventHandler
-(IBAction)wishButtonTouch:(UIButton*)sender{
    if(wishSelected == YES)
        [[NSNotificationCenter defaultCenter]postNotificationName:@"myLibrary_tabtouched" object:self];
}

-(UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header forIndexPath:indexPath];
    
    readButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 160, 30)];
    wishButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 20, 160, 30)];
    readButton.backgroundColor = UIColorFromRGB(0xEF4089);
    wishButton.backgroundColor = UIColorFromRGB(0xB3B3B3);
    readSelected = YES;
    wishSelected = NO;
    [readButton setTitle:@"봤어요" forState:UIControlStateNormal];
    [wishButton setTitle:@"보고싶어요" forState:UIControlStateNormal];
    
    [readButton addTarget:self action:@selector(readButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [wishButton addTarget:self action:@selector(wishButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:readButton];
    [headerView addSubview:wishButton];
    
    return headerView;
}

-(void)readAction:(UIButton *)button {
    
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
