//
//  ZBarQRCodeViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/17.
//  Copyright © 2015年 soez. All rights reserved.
//
/*扫描二维码部分：
 导入ZBarSDK文件并引入一下框架
 AVFoundation.framework
 CoreMedia.framework
 CoreVideo.framework
 QuartzCore.framework
 libiconv.dylib
 引入头文件#import “ZBarSDK.h” 即可使用
 当找到条形码时，会执行代理方法
 
 - (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
 
 最后读取并显示了条形码的图片和内容。*/

#import "ZBarQRCodeViewController.h"
#import "UIDefines.h"
#import "ZBarSDK.h"
#import "ZXingQRCodeViewController.h"

@interface ZBarQRCodeViewController ()
{
    UIImageView *imageView;
    UILabel *label;
}
@end

@implementation ZBarQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZBar二维码扫描";
    self.view.backgroundColor = BGColor;
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, NAV_HEIGHT+20, MAINSCREEN_WIDTH-40, MAINSCREEN_WIDTH-40)];
    [self.view addSubview:imageView];
    imageView.backgroundColor = [UIColor cyanColor];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(imageView)+20, MAINSCREEN_WIDTH, 21)];
    [self.view addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(8, MaxY(label)+20, MAINSCREEN_WIDTH-16, 40)];
    [self.view addSubview:btn];
    [btn setTitle:@"开始扫描" forState:UIControlStateNormal];
    [btn setBackgroundColor:BlueBtnColor];
    [btn addTarget:self action:@selector(startScan:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *zxingBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, MaxY(btn)+20, MAINSCREEN_WIDTH-16, 40)];
    [self.view addSubview:zxingBtn];
    [zxingBtn setTitle:@"用ZXing做二维码扫描" forState:UIControlStateNormal];
    [zxingBtn setBackgroundColor:BlueBtnColor];
    [zxingBtn addTarget:self action:@selector(turnToZXing) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)turnToZXing{
    
}

- (void)startScan:(UIButton *)sender{
    
    ZBarReaderViewController *reader = [[ZBarReaderViewController alloc] init];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    [self presentViewController:reader animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //第一种   --------
    // ADD: get the decode results
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        // EXAMPLE: just grab the first barcode
//        break;
//    
//    // EXAMPLE: do something useful with the barcode data
//    label.text = symbol.data;
//    
//    // EXAMPLE: do something useful with the barcode image
//    imageView.image =
//    [info objectForKey: UIImagePickerControllerOriginalImage];
//    
//    // ADD: dismiss the controller (NB dismiss from the *reader*!)
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    //第二种 ---------
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    imageView.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //判断是否包含 头'http:'
    NSString *regex = @"http+:[^\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    //判断是否包含 头'ssid:'
    NSString *ssid = @"ssid+:[^\\s]*";;
    NSPredicate *ssidPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ssid];
    
    label.text =  symbol.data ;
    
    if ([predicate evaluateWithObject:label.text]) {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil
                                                        message:@"It will use the browser to this URL。"
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:@"Ok", nil];
        alert.delegate = self;
        alert.tag=1;
        [alert show];
        
        
        
    }
    else if([ssidPre evaluateWithObject:label.text]){
        
        NSArray *arr = [label.text componentsSeparatedByString:@";"];
        
        NSArray * arrInfoHead = [[arr objectAtIndex:0] componentsSeparatedByString:@":"];
        
        NSArray * arrInfoFoot = [[arr objectAtIndex:1] componentsSeparatedByString:@":"];
        
        
        label.text=
        [NSString stringWithFormat:@"ssid: %@ \n password:%@",
         [arrInfoHead objectAtIndex:1],[arrInfoFoot objectAtIndex:1]];
        
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:label.text
                                                        message:@"The password is copied to the clipboard , it will be redirected to the network settings interface"
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:@"Ok", nil];
        
        
        alert.delegate = self;
        alert.tag=2;
        [alert show];
        
        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
        //        然后，可以使用如下代码来把一个字符串放置到剪贴板上：
        pasteboard.string = [arrInfoFoot objectAtIndex:1];
        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
