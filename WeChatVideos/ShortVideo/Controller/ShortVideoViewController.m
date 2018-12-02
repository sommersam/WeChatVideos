//
//  ShortVideoViewController.m
//  WeChatVideos
//
//  Created by Joonjung on 2018/12/2.
//  Copyright © 2018 JunJie. All rights reserved.
//

#import "ShortVideoViewController.h"
#import "CameraButton.h"
#import <AVFoundation/AVFoundation.h>
@interface ShortVideoViewController () <CameraButtonDelegate>

@property (nonatomic, strong) UIView *preView; //预览视图

@property (nonatomic, strong) UIColor *cancelColor; //取消进度的颜色
@property (nonatomic, strong) UIImageView *focusImage; //聚焦图
@property (nonatomic, assign) BOOL isFocusing; //记录是否正在聚焦

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机预览图层


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
    [_preView addSubview:_focusImage];
    _focusImage.center = _preView.center;
    _focusImage.alpha = 0.0f;
    
    
    //点击手势
    [self addTapGesture];
}

//点击聚焦手势
- (void)addTapGesture
{
    //单击聚焦手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusAction:)];
    [self.preView addGestureRecognizer:tap];
    
    //双击放大手势
    UITapGestureRecognizer *DoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enlargeAction:)];
    DoubleTap.numberOfTapsRequired = 2;
    [tap requireGestureRecognizerToFail:DoubleTap];
    [self.preView addGestureRecognizer:DoubleTap];
    
}

/** 单击手势*/
- (void)focusAction:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.preView];
    [self focusActionWithPoint:point];
}

- (void)focusActionWithPoint:(CGPoint)point
{
    if (self.isFocusing) {
        return;
    }
    self.isFocusing = YES;
    //UI点击坐标转化为摄像头坐标
    CGPoint cameraPoint = [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    [self setFocusCursoWithPoint:point];
}

/** 设置聚焦光标的位置 */
- (void)setFocusCursoWithPoint:(CGPoint)point
{
    self.focusImage.center = point;
    self.focusImage.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.focusImage.alpha = 1.f;
    [UIView animateWithDuration:0.3 animations:^{
        self.focusImage.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.focusImage.alpha = 0.0f;
    }];
    
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
