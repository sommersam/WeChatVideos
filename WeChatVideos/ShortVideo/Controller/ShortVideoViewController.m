//
//  ShortVideoViewController.m
//  WeChatVideos
//
//  Created by Joonjung on 2018/12/2.
//  Copyright © 2018 JunJie. All rights reserved.
//

#import "ShortVideoViewController.h"
#import "CameraButton.h"
@interface ShortVideoViewController () <CameraButtonDelegate>

@end

@implementation ShortVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
}



- (void)setUI
{
    self.view.backgroundColor = [UIColor blackColor];
    //录制视频的按钮
    CameraButton *btn = [[CameraButton alloc] initWithFrame:CGRectMake((kScreen_Width - 80) * 0.5, kScreen_Height - 200, 80, 80)];
    btn.delegate = self;
    [self.view addSubview:btn];
}

/** CameraButtonDelagate*/
- (void)CameraControl:(CameraButton *)button gestureRecognizer:(UIGestureRecognizer *)gest
{
    
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
