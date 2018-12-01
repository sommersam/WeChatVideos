//
//  CameraButton.m
//  WeChatCamera
//
//  Created by Joonjung on 2018/8/22.
//  Copyright © 2018年 Joonjung. All rights reserved.
//

#import "CameraButton.h"

@implementation CameraButton {
    
    UIView *_outerView;
    UIView *_centerView;
    /** lineWidth */
    CGFloat _width;
    CGFloat _progress;
    CAShapeLayer *_progressLayer;
    NSTimer *_timer;
    
    CGFloat _animatetionTime;
    CGFloat _animatetionIncr;
}




- (void)setDuration:(NSInteger)duration
{
    _duration = duration;
    _animatetionTime = 1 / (CGFloat)(duration * duration);
    _animatetionIncr = 1 / (CGFloat)(duration * duration * duration);
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        
        _outerView = [[UIView alloc] initWithFrame:self.bounds];
        _outerView.layer.cornerRadius = self.width * 0.5;
        _outerView.backgroundColor = RGBColor(175, 175, 175);
        _outerView.alpha = 0.9;
        [self addSubview:_outerView];
        
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        _centerView.center = _outerView.center;
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.cornerRadius = _centerView.width * 0.5;
        [self addSubview:_centerView];
        
        /** 长按手势 */
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_centerView addGestureRecognizer:longPress];
        
        /** 点按手势 */
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        /** 填充贝塞尔曲线宽度 */
        _width = 5;
        
        /** 添加图层 */
        _progressLayer = [[CAShapeLayer alloc] init];
        [_outerView.layer addSublayer:_progressLayer];
        _progressLayer.fillColor = nil;
        _progressLayer.lineCap = kCALineCapSquare;
        _progressLayer.frame = _outerView.bounds;
        _progressLayer.lineWidth = _width;
        _progressLayer.strokeColor = RGBColor(90, 165, 88).CGColor;
        
        /** 默认录制十秒 */
        self.duration = 10;
    }
    return self;
}


- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    /** 实现录制保存代理 */
    if (self.delegate && [self.delegate respondsToSelector:@selector(CameraControl:gestureRecognizer:)]) {

        [self.delegate CameraControl:self gestureRecognizer:longPress];
}
    __weak typeof(self)WeakSelf = self;
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:{
            [UIView animateWithDuration:0.3 animations:^{
                _centerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
                _outerView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            }];
            [self start];
        }
            break;
            
        case UIGestureRecognizerStateEnded:{
            [UIView animateWithDuration:0.3 animations:^{
                _centerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                _outerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
            [self stop];
        }
            
            break;
        
        case UIGestureRecognizerStateChanged:
            break;
            
        case UIGestureRecognizerStateCancelled:{
            
            [self stop];
        }
            
            break;
            
        default:
            break;
    }
    
}


- (void)start
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:_animatetionTime target:self selector:@selector(addProgress) userInfo:nil repeats:YES];
}

- (void)addProgress
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        _progress += _animatetionIncr;
        [self updateProgress];
        if (_progress > 1) {
            [self stop];
        }
    });
}

- (void)setProgress
{
    _progress = 0;
    UIBezierPath *progessPath = [UIBezierPath bezierPathWithArcCenter:_centerView.center radius:(_outerView.width - (1.5 * _width)) / 3 startAngle:(M_PI_2 * 3) endAngle:-M_PI_2 clockwise:YES];
    
    _progressLayer.path = progessPath.CGPath;
}

- (void)updateProgress
{
    UIBezierPath *progessPath = [UIBezierPath bezierPathWithArcCenter:_centerView.center radius:(_outerView.width - (1.5 * _width)) / 3 startAngle:(M_PI_2 * 3) endAngle:(M_PI * 2) *_progress + (-M_PI_2) clockwise:YES];
    
    _progressLayer.path = progessPath.CGPath;
}

- (void)stop
{
    [_timer invalidate];
    _timer = nil;
    [self setProgress];
}

@end
