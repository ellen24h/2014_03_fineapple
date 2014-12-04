//
//  test.m
//  NEXT_Library
//
//  Created by Ducky on 2014. 12. 3..
//  Copyright (c) 2014년 FineApple. All rights reserved.
//

#import "test.h"

@interface test ()

@end

@implementation test

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLoadingAnimation];
    NSString * userData = [[NSString alloc] initWithFormat:@"test"];
    NSData * postData = [userData dataUsingEncoding:NSUTF8StringEncoding];
    NSString * dataLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL * url = [NSURL URLWithString:@"http://127.0.0.1:5009/veryFirstConnect"];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:dataLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(connection){
        recvData = [[NSMutableData alloc] init];
        NSLog(@"connection success");
    }
    else{
        NSLog(@"connection fail");
    }

}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [recvData setLength:0];
    [recvData appendData:data];
    NSString * recvData_str =[[NSString alloc]initWithData:recvData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",recvData_str);
    label.text = recvData_str;
}

-(void)setLoadingAnimation{
    NSLog(@"ASFDS");
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
    imgView.animationImages = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"frame-000000.png"],
                               [UIImage imageNamed:@"frame-000001.png"],
                               [UIImage imageNamed:@"frame-000002.png"],
                               [UIImage imageNamed:@"frame-000003.png"],
                               [UIImage imageNamed:@"frame-000004.png"],
                               [UIImage imageNamed:@"frame-000005.png"],
                               [UIImage imageNamed:@"frame-000006.png"],
                               [UIImage imageNamed:@"frame-000007.png"],
                               [UIImage imageNamed:@"frame-000008.png"],
                               [UIImage imageNamed:@"frame-000009.png"],
                               [UIImage imageNamed:@"frame-000010.png"],
                               [UIImage imageNamed:@"frame-000011.png"],
                               [UIImage imageNamed:@"frame-000012.png"],
                               [UIImage imageNamed:@"frame-000013.png"],
                               [UIImage imageNamed:@"frame-000014.png"],
                               [UIImage imageNamed:@"frame-000015.png"],
                               [UIImage imageNamed:@"frame-000016.png"],
                               [UIImage imageNamed:@"frame-000017.png"],
                               [UIImage imageNamed:@"frame-000018.png"],
                               [UIImage imageNamed:@"frame-000019.png"],
                               [UIImage imageNamed:@"frame-000020.png"],
                               [UIImage imageNamed:@"frame-000021.png"],
                               [UIImage imageNamed:@"frame-000022.png"],
                               [UIImage imageNamed:@"frame-000023.png"],
                               [UIImage imageNamed:@"frame-000024.png"],
                               [UIImage imageNamed:@"frame-000025.png"],
                               [UIImage imageNamed:@"frame-000026.png"],
                               [UIImage imageNamed:@"frame-000027.png"],
                               [UIImage imageNamed:@"frame-000028.png"],
                               [UIImage imageNamed:@"frame-000029.png"],
                               [UIImage imageNamed:@"frame-000030.png"],
                               [UIImage imageNamed:@"frame-000031.png"],
                               [UIImage imageNamed:@"frame-000032.png"],
                               [UIImage imageNamed:@"frame-000033.png"],
                               [UIImage imageNamed:@"frame-000034.png"],
                               [UIImage imageNamed:@"frame-000035.png"],
                               [UIImage imageNamed:@"frame-000036.png"],
                               [UIImage imageNamed:@"frame-000037.png"],
                               [UIImage imageNamed:@"frame-000038.png"],
                               [UIImage imageNamed:@"frame-000039.png"],
                               [UIImage imageNamed:@"frame-000040.png"],
                               [UIImage imageNamed:@"frame-000041.png"],
                               [UIImage imageNamed:@"frame-000042.png"],
                               [UIImage imageNamed:@"frame-000043.png"],
                               [UIImage imageNamed:@"frame-000044.png"],
                               [UIImage imageNamed:@"frame-000045.png"],
                               [UIImage imageNamed:@"frame-000046.png"],
                               [UIImage imageNamed:@"frame-000047.png"],
                               [UIImage imageNamed:@"frame-000048.png"],
                               [UIImage imageNamed:@"frame-000049.png"],                             nil];
    [imgView setAnimationRepeatCount:-1];
    imgView.animationDuration = .5;
    [imgView startAnimating];
    
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
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

@end
