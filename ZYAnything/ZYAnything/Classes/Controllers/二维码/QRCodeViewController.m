//
//  QRCodeViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/16.
//  Copyright © 2015年 soez. All rights reserved.
//

/*
 做iOS的二维码扫描，有两个第三方库可以选择，ZBar和ZXing。
 iOS7.0后可以用AVFoundation框架提供的原生二维码扫描
 */
/*
步骤如下：
1.导入AVFoundation框架，引入<AVFoundation/AVFoundation.h>
2.设置一个用于显示扫描的view
3.实例化AVCaptureSession、AVCaptureVideoPreviewLayer
*/
#import "QRCodeViewController.h"
#import "UIDefines.h"
#import "QRCodeGenerator.h"
#import "ZBarQRCodeViewController.h"

@interface QRCodeViewController ()<UITextFieldDelegate,AVCaptureMetadataOutputObjectsDelegate>


@end

@implementation QRCodeViewController
#pragma mark - 把输入的字符串转换为二维码
/*
 导入libqrencode文件
 引入头文件#import "QRCodeGenerator.h"即可使用
 */
- (void)changeStringToCode{
    [_codeText resignFirstResponder];
    NSString *str = _codeText.text;
    NSLog(@"需要转成二维码的字符串：%@",str);
    
    
    [self.view addSubview:_imageView];
    _imageView.image = [QRCodeGenerator qrImageForString:str imageSize:_imageView.bounds.size.width];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissQRCode)];
    [_imageView addGestureRecognizer:tap];
    _imageView.userInteractionEnabled = YES;
    
}

- (void)dismissQRCode{
    [_imageView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavBack:@selector(backAction)];
//    [self setNavTitle:@"二维码"];
    self.view.backgroundColor = BGColor;
    
    _captureSession = nil;
    _isReading = NO;
    
    _codeText = [[UITextField alloc] initWithFrame:CGRectMake(8, 8, MAINSCREEN_WIDTH-100, 30)];
    [self.view addSubview:_codeText];
    _codeText.delegate = self;
    _codeText.placeholder = @"输入字符串生成二维码";
    
    _changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH-100, 8, 80, 30)];
    [self.view addSubview:_changeBtn];
    [_changeBtn setTitle:@"生成" forState:UIControlStateNormal];
    [_changeBtn setBackgroundColor:BlueBtnColor];
    [_changeBtn addTarget:self action:@selector(changeStringToCode) forControlEvents:UIControlEventTouchUpInside];
    //二维码图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH/2.f-120, 100, 240, 240)];
    
    _viewPreview = [[UIView alloc] initWithFrame:CGRectMake(8, MaxY(_codeText)+8, MAINSCREEN_WIDTH-16, MAINSCREEN_HEIGHT-NAV_HEIGHT-200)];
    [self.view addSubview:_viewPreview];
    _viewPreview.layer.masksToBounds = YES;
    _viewPreview.layer.borderWidth = 1;
    _viewPreview.layer.borderColor = BlueBtnColor.CGColor;
    
    _lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, MidY(_viewPreview)-15, _viewPreview.bounds.size.width, 30)];
    _lblStatus.textColor = [UIColor blackColor];
    [_viewPreview addSubview:_lblStatus];
    _lblStatus.textAlignment = NSTextAlignmentCenter;
    _lblStatus.text = @"二维码扫描";
    
    
    _startScanBtn = [[UIButton alloc] initWithFrame:CGRectMake(8,MAINSCREEN_HEIGHT-104-64, MAINSCREEN_WIDTH-16, 40)];
    [self.view addSubview:_startScanBtn];
    [_startScanBtn setBackgroundColor:BlueBtnColor];
    [_startScanBtn setTitle:@"开始扫描" forState:UIControlStateNormal];
    [_startScanBtn addTarget:self action:@selector(startStopReading:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *zbarBtn = [[UIButton alloc] initWithFrame:CGRectMake(8,MAINSCREEN_HEIGHT-50-64, MAINSCREEN_WIDTH-16, 40)];
    [self.view addSubview:zbarBtn];
    [zbarBtn setBackgroundColor:BlueBtnColor];
    [zbarBtn setTitle:@"用ZBar做二维码扫描" forState:UIControlStateNormal];
    [zbarBtn addTarget:self action:@selector(turnToZBarVC) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)turnToZBarVC{
    
    ZBarQRCodeViewController *zbarVC = [[ZBarQRCodeViewController alloc] init];
    [self.navigationController pushViewController:zbarVC animated:YES];
    
}

#pragma mark - 扫描二维码
- (void)startStopReading:(UIButton *)sender{
    
    [_imageView removeFromSuperview];
    
    if (!_isReading) {
        if ([self startReading]) {
            [_startScanBtn setTitle:@"停止扫描" forState:UIControlStateNormal];
            [_lblStatus setText:@"二维码扫描"];
        }
    }
    else{
        [self stopReading];
//        [_startScanBtn setTitle:@"开始扫描" forState:UIControlStateNormal];
    }
    
    _isReading = !_isReading;
}

- (BOOL)startReading{
    NSError *error;
    //1.初始化捕捉设备(AVCaptureDevice),类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@",[error localizedDescription]);
        return NO;
    }
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    //4.1将输入流添加到会话中
    [_captureSession addInput:input];
    //4.2将媒体输出流添加到队列当中
    [_captureSession addOutput:captureMetadataOutput];
    //5.创建串行队列，并加媒体输出流到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2设置输出媒体数据类型位QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    //9.将图层添加到预览view的图层上
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    //10.1扫描框
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(_viewPreview.bounds.size.width*0.2f, _viewPreview.bounds.size.height*0.2f, _viewPreview.bounds.size.width*(1-0.4f), _viewPreview.bounds.size.height*(1-0.4f))];
    _boxView.layer.borderColor = [UIColor greenColor].CGColor;
    _boxView.layer.borderWidth = 1.0f;
    [_viewPreview addSubview:_boxView];
    
    //10.2扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
    [_boxView.layer addSublayer:_scanLayer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [timer fire];
    //11.开始扫描
    [_captureSession startRunning];
    
    
    
    
    
    return YES;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [_lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            _isReading = NO;
        }
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
    }else{
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}


- (void)stopReading{
    [_startScanBtn setTitle:@"开始扫描" forState:UIControlStateNormal];
    [_captureSession stopRunning];
    _captureSession = nil;
    [_scanLayer removeFromSuperlayer];
    [_videoPreviewLayer removeFromSuperlayer];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [_codeText resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_codeText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
