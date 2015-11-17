//
//  PilotView.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/17.
//  Copyright © 2015年 soez. All rights reserved.
//

#import "PilotView.h"
#import "UIDefines.h"

@implementation PilotView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT);
        NSArray *imageNameAry = @[@"qd01",@"qd02",@"qd03"];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [scrollView setContentSize:CGSizeMake(MAINSCREEN_WIDTH*imageNameAry.count, 0)];
        [self addSubview:scrollView];
        
        UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH*(imageNameAry.count-0.71), MAINSCREEN_HEIGHT*0.79, MAINSCREEN_WIDTH*0.42, 45/320.f*MAINSCREEN_WIDTH)];
        for (int i = 0; i < imageNameAry.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*MAINSCREEN_WIDTH, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
            [imageView setImage:[UIImage imageNamed:imageNameAry[i]]];
            [imageView setBackgroundColor:RGBA(122, 23, arc4random()%255, 1)];
            if (MAINSCREEN_HEIGHT <= 480) {
                if (i == 0) {
                    imageView.frame = CGRectMake(i*MAINSCREEN_WIDTH, -55, MAINSCREEN_WIDTH, 568);
                }else{
                    imageView.frame = CGRectMake(i*MAINSCREEN_WIDTH, -30, MAINSCREEN_WIDTH, 568);
                }
                startBtn.frame = CGRectMake(MAINSCREEN_WIDTH*(imageNameAry.count-0.71), MAINSCREEN_HEIGHT-65, MAINSCREEN_WIDTH*0.42, 45);
            }
            [scrollView addSubview:imageView];
            
        }
        [scrollView addSubview:startBtn];
        startBtn.layer.masksToBounds = YES;
        startBtn.layer.cornerRadius = 3;
        [startBtn setImage:[UIImage imageNamed:@"lijitiyan"] forState:UIControlStateNormal];
        [startBtn addTarget:self action:@selector(startBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)startBtnAction{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self removeFromSuperview];
    
}

@end
