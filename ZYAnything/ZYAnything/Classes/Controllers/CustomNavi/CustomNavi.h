//
//  CustomNavi.h
//  ZYAnything
//
//  Created by ZhangZiyao on 15/12/16.
//  Copyright © 2015年 soez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavi : UIView

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,copy) void(^imageActionBlock)();

- (id)initWithFrame:(CGRect)frame backgroundImage:(NSString *)bgImageName headerImageURL:(NSString *)headerImageURL title:(NSString *)title subTitle:(NSString *)subTitle;

- (void)updateSubviewsWithScrollOffset:(CGPoint)newOffset;

@end
