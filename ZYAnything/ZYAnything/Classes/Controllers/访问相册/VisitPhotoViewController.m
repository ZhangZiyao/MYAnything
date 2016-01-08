//
//  VisitPhotoViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/15.
//  Copyright © 2015年 soez. All rights reserved.
//

#import "VisitPhotoViewController.h"
#import "UIDefines.h"

@interface VisitPhotoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIAlertController *actionSheet;
    UIImageView *photo;
}
@end

@implementation VisitPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavBack:@selector(backAction)];
//    [self setNavTitle:@"选择照片"];
    self.view.backgroundColor = BGColor;
    
    photo = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH/2.f-100, 80, 200, 200)];
    photo.backgroundColor = BlueBtnColor;
    [self.view addSubview:photo];
    photo.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhotoAction:)];
    [photo addGestureRecognizer:tap];
}

- (void)selectPhotoAction:(UITapGestureRecognizer *)tap{
    actionSheet = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *fromPhotoLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentPhoto];
    }];
    [actionSheet addAction:cancel];
    [actionSheet addAction:fromPhotoLibrary];
#if TARGET_IPHONE_SIMULATOR
    
#else
    UIAlertAction *fromCamera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentCamera];
    }];
   
    [actionSheet addAction:fromCamera];
#endif
    
    [self presentViewController:actionSheet animated:YES completion:^{
        
    }];
}

#pragma mark - 打开相机
- (void)presentCamera{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }
    
    
}

#pragma mark - 打开相册
- (void)presentPhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }
}

#pragma mark - imagePickerViewDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //展示图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    photo.image = image;
    //保存图片到本地
    [self saveImage:image withName:@"currentImage.png"];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    //获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


/*
 //高保真压缩图片方法
 NSData * UIImageJPEGRepresentation ( UIImage *image, CGFloat compressionQuality
 )
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
