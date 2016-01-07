//
//  CustomNavi.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/12/16.
//  Copyright © 2015年 soez. All rights reserved.
//

#import "CustomNavi.h"

@interface CustomNavi ()

@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,assign) CGPoint prePoint;

@end

@implementation CustomNavi

- (id)initWithFrame:(CGRect)frame backgroundImage:(NSString *)bgImageName headerImageURL:(NSString *)headerImageURL title:(NSString *)title subTitle:(NSString *)subTitle{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -0.5*frame.size.height, frame.size.width, frame.size.height*1.5)];
        _backgroundImageView.image = [UIImage imageNamed:bgImageName];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*0.5-70*0.5, 0.27*frame.size.height, 70, 70)];
//        [_headerImageView sd]
        
    }
    return self;
}


@end
