//
// RETableViewCellStyle.h
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
#import <Foundation/Foundation.h>
#import "RETableViewCell.h"

@interface RETableViewCellStyle : NSObject <NSCopying>

@property (assign, readwrite, nonatomic) CGFloat cellHeight;
@property (assign, readwrite, nonatomic) UITableViewCellSelectionStyle defaultCellSelectionStyle;
@property (assign, readwrite, nonatomic) CGFloat backgroundImageMargin;
@property (assign, readwrite, nonatomic) CGFloat contentViewMargin;
@property (strong, readwrite, nonatomic) NSMutableDictionary *backgroundImages;
@property (strong, readwrite, nonatomic) NSMutableDictionary *selectedBackgroundImages;

- (BOOL)hasCustomBackgroundImage;
- (UIImage *)backgroundImageForCellType:(RETableViewCellType)cellType;
- (void)setBackgroundImage:(UIImage *)image forCellType:(RETableViewCellType)cellType;

- (BOOL)hasCustomSelectedBackgroundImage;
- (UIImage *)selectedBackgroundImageForCellType:(RETableViewCellType)cellType;
- (void)setSelectedBackgroundImage:(UIImage *)image forCellType:(RETableViewCellType)cellType;

@end
