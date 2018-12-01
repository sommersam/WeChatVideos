//
//  CameraButton.h
//  WeChatCamera
//
//  Created by Joonjung on 2018/8/22.
//  Copyright © 2018年 Joonjung. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 实现录制功能使用的代理 */
@class CameraButton;

@protocol CameraButtonDelegate <NSObject>

@required
- (void)CameraControl:(CameraButton *)button gestureRecognizer:(UIGestureRecognizer *)gest;

@end

@interface CameraButton : UIView

@property (nonatomic, weak) id<CameraButtonDelegate> delegate;

@property (nonatomic, assign) NSInteger duration;


@end
