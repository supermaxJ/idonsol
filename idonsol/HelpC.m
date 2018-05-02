//
//  HelpC.m
//  idonsol
//
//  Created by 蒋宇 on 2017/9/12.
//  Copyright © 2017年 snakejay. All rights reserved.
//

#import "HelpC.h"

@interface HelpC ()
@property (weak, nonatomic) IBOutlet UIWebView *ibWebView;

@end

@implementation HelpC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.ibWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sohu.com/a/126066892_485902"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)ibaCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
