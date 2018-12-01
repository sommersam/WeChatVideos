//
//  ViewController.m
//  WeChatVideos
//
//  Created by JunJie on 2018/12/1.
//  Copyright © 2018 JunJie. All rights reserved.
//

#import "ViewController.h"

#import "ShortVideoViewController.h"


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
    [btn addTarget:self action:@selector(pushToShortVideoController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)pushToShortVideoController:(UIButton *)sender
{
    [self presentViewController:[ShortVideoViewController new] animated:YES completion:nil];
}


@end
