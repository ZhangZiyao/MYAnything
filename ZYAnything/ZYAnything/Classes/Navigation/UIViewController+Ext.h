//
//  UIViewController+Ext.h
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/28.
//  Copyright © 2015年 soez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Ext)

- (void)setNavColor;

- (void)setNavTitle:(NSString *)title;

- (void)setNavLeftBarButton:(CGRect)frame
                      title:(NSString *)title
                     action:(SEL)action
                normalImage:(UIImage *)normalImage
             highlightImage:(UIImage *)highlightImage;

- (void)setNavRightBarButton:(CGRect)frame
                       title:(NSString *)title
                      action:(SEL)action
                 normalImage:(UIImage *)normalImage
              highlightImage:(UIImage *)highlightImage;

#pragma mark -
- (void)setNavBack:(SEL)action;
#pragma mark -
- (void)setNavNull;

@end
