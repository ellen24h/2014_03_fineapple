//
//  PostingViewController.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 16..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "PostingViewController.h"

@implementation PostingViewController

- (void)viewDidLoad{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(naverBookData:) name:@"naverBookData" object:nil];
    model = [postingModel sharedPostingModel];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bookSelected:) name:@"bookSelected" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancelEdit:) name:@"cancelEdit" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(postingDone:) name:@"postingDone" object:nil];
}

-(void)postingDone:(NSNotification *)noti{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)bookSelected:(NSNotification *)noti{
    _searchBarTextField.text =@"";
    _searchBarTextField.enabled = NO;
    _cancelButton.enabled = YES;
    serachResultBookButton * button = noti.object;
    UIView * searchResultView = [self.view viewWithTag:searchResultViewTag];
    [searchResultView removeFromSuperview];
    [_cancelButton setTitle:@"X" forState:UIControlStateNormal];
    _selectBookTitle.text = button->bookTitle;
    _selectBookAuthor.text = button->bookAuthor;
    selectBookImg = button->bookImg;
    _selectBookImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:button->bookImg]]];
    NSArray * isbn_arr = [[NSArray alloc]initWithArray:
                          [button->bookIsbn componentsSeparatedByString:@" "]];
    selectBookIsbn = [isbn_arr objectAtIndex:isbn_arr.count-1];
}
- (IBAction)cancelButtonTouched:(id)sender {
    _searchBarTextField.enabled = YES;
    _selectBookTitle.text=@"";
    _selectBookAuthor.text=@"";
    _selectBookImg.image=nil;
    [_cancelButton setTitle:@"" forState:UIControlStateNormal];
    _cancelButton.enabled = NO;
    selectBookIsbn = @"";
    selectBookImg = @"";
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"본문을 입력해주세요."] == YES || [textView.text length] == 0){
        textView.text=@"";
    }
    textView.textColor = UIColorFromRGB(FINE_DARKGRAY);
    return YES;
}
- (IBAction)searchTextFieldTouched:(id)sender {
    _searchBarTextField.textColor = UIColorFromRGB(FINE_DARKGRAY);
    isViewPosUp = YES;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.view.frame;
    rect.origin.y -= (kOFFSET_FOR_KEYBOARD*2+50);
    rect.size.height += (kOFFSET_FOR_KEYBOARD*2+50);
    self.view.frame = rect;
    [UIView commitAnimations];
}
- (IBAction)editEnd:(id)sender {
    if(isViewPosUp == YES){
        isViewPosUp = NO;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        CGRect rect = self.view.frame;
        rect.origin.y += (kOFFSET_FOR_KEYBOARD*2+50);
        rect.size.height -= (kOFFSET_FOR_KEYBOARD*2+50);
        self.view.frame = rect;
        [UIView commitAnimations];
        [self.view endEditing:YES];
    }
}
- (IBAction)postButtonTouched:(id)sender{
    if([_postText.text isEqualToString:@""] == YES ||
       [_postText.text isEqualToString:@"본문을 입력해주세요."] == YES){
        _postText.textColor = UIColorFromRGB(FINE_PINK);
        _postText.text = @"본문을 입력해주세요.";
    }
    else if([selectBookIsbn length] == 0){
        _searchBarTextField.textColor = UIColorFromRGB(FINE_PINK);
        _searchBarTextField.text = @"도서를 반드시 첨부하셔야합니다.";
    }
    else{
        NSMutableDictionary * postInfo = [[NSMutableDictionary alloc]init];
        [postInfo setValue:_postText.text forKey:@"post"];
        [postInfo setValue:selectBookImg forKey:@"postImg"];
        [postInfo setValue:selectBookIsbn forKey:@"postISBN"];
    
        [[NSNotificationCenter defaultCenter]postNotificationName:@"postingSendToServer" object:postInfo];
    }
}
- (IBAction)allCancelButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancelEdit:(NSNotification *)noti{
    if(isViewPosUp == YES){
        [self editEnd:_searchBarTextField];
    }
    else{
        [self.view endEditing:YES];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(isViewPosUp == YES){
        [self editEnd:_searchBarTextField];
    }
    else{
        [self.view endEditing:YES];
    }
}

-(void)naverBookData:(NSNotification *)noti{
    NSArray * bookData = noti.object;
    UIView * searchResultView = [_postingScrollview viewWithTag:searchResultViewTag];
    if(bookData.count == 0){
        [searchResultView removeFromSuperview];
    }
    else{
        [searchResultView removeFromSuperview];
        float searchResultHeight = self.view.frame.size.height*0.2;
        float resultButtonHeight = searchResultHeight/NAVER_DISPLAY_NUM;
        searchResultView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.65-(kOFFSET_FOR_KEYBOARD-13)*2, self.view.frame.size.width*0.9, searchResultHeight)];
        searchResultView.tag = searchResultViewTag;
        searchResultView.backgroundColor = [UIColor clearColor];
        [_postingScrollview addSubview:searchResultView];
        for(int i = 0 ; i < bookData.count ; i++){
            serachResultBookButton * bookButton = [[serachResultBookButton alloc]initWithFrame:CGRectMake(0, resultButtonHeight*i, searchResultView.frame.size.width, resultButtonHeight)];
            bookButton.tag = i;
            [bookButton
             setTitle:[NSString stringWithFormat:@" %@ / %@",[[bookData objectAtIndex:i] objectAtIndex:title],[[bookData objectAtIndex:i] objectAtIndex:author]] forState:UIControlStateNormal];
            bookButton.titleLabel.font = [UIFont systemFontOfSize:14];
            bookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            bookButton.titleLabel.textColor = [UIColor whiteColor];
            if(i%2 ==0){
                bookButton.backgroundColor = UIColorFromRGB(FINE_LIGHTGRAY);
            }
            else{
                bookButton.backgroundColor = UIColorFromRGB(FINE_DARKGRAY);
            }
            bookButton.enabled = YES;
            [bookButton setProperty:[[bookData objectAtIndex:i]objectAtIndex:title] bookImg:[[bookData objectAtIndex:i]objectAtIndex:img] bookAuthor:[[bookData objectAtIndex:i]objectAtIndex:author] bookIsbn:[[bookData objectAtIndex:i]objectAtIndex:isbn]];
            [searchResultView addSubview:bookButton];
        }
    }
   
}

@end
