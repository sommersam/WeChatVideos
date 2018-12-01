//
//  ViewController.m
//  WeChatVideos
//
//  Created by JunJieXia on 2018/12/1.
//  Copyright © 2018 JunJie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"微信小视频" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.frame = CGRectMake(0, 0, 200, 70);
    btn.center = self.view.center;
    [self.view addSubview:btn];
    
}


@end
