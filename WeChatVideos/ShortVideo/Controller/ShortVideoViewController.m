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

@property (nonatomic, strong) UIView *preView; //预览视图

@property (nonatomic, strong) UIColor *cancelColor; //取消进度的颜色
@property (nonatomic, strong) UIImageView *focusImage; //聚焦图

@end

@implementation ShortVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
}



- (void)setUI
{
    self.view.backgroundColor = [UIColor blackColor];
    
    //预览视图
    _preView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _preView.backgroundColor = [UIColor blackColor];
    _preView.layer.masksToBounds = YES;
    [self.view addSubview:_preView];
    
    //录制视频的按钮
    CameraButton *btn = [[CameraButton alloc] initWithFrame:CGRectMake((kScreen_Width - 80) * 0.5, kScreen_Height - 200, 80, 80)];
    btn.delegate = self;
    [self.view addSubview:btn];
    
    
    //提示框
    CGFloat CameraBtnBottom = btn.frame.origin.y + btn.frame.size.height;
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width - 80)/2, CameraBtnBottom - 60, 80, 20)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:16];
    tipLabel.text = @"双击放大";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.alpha = 0.0f;
    [self.view addSubview:tipLabel];
    
    //录制松开提示框
    UILabel *warningLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width - 100)/2, CameraBtnBottom - 250, 100, 20)];
    warningLabel.textAlignment = NSTextAlignmentCenter;
    warningLabel.font = [UIFont systemFontOfSize:16];
    warningLabel.text = @"手指不要松开";
    warningLabel.textColor = [UIColor whiteColor];
    warningLabel.alpha = 0.0f;
    warningLabel.backgroundColor = _cancelColor;
    [self.view addSubview:warningLabel];
    
    
    //聚焦图
    _focusImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _focusImage.image = [UIImage imageNamed:@"WechatShortVideo_scan_focus"];
    
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
