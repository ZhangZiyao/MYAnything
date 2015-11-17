//
//  QRCodeViewController.h
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/16.
//  Copyright © 2015年 soez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRCodeViewController : UIViewController

@property (nonatomic,strong) UITextField *codeText;
@property (nonatomic,strong) UIButton *changeBtn;
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIView *viewPreview;
@property (nonatomic,strong) UIButton *startScanBtn;
@property (nonatomic,strong) UILabel *lblStatus;

- (void)startStopReading:(UIButton *)sender;

@property (nonatomic,strong) UIView *boxView;
@property (nonatomic) BOOL isReading;
@property (strong,nonatomic) CALayer *scanLayer;

- (BOOL)startReading;
- (void)stopReading;

//捕捉会话
@property (nonatomic,strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end
