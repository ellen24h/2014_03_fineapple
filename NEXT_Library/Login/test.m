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
