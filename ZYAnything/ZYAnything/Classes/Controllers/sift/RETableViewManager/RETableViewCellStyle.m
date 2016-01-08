//
// RETableViewCellStyle.m
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//

#import "RETableViewCellStyle.h"
#import "RETableViewManager.h"

@implementation RETableViewCellStyle

- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    _backgroundImages = [[NSMutableDictionary alloc] init];
    _selectedBackgroundImages = [[NSMutableDictionary alloc] init];
    _cellHeight = 44.0;
    _defaultCellSelectionStyle = UITableViewCellSelectionStyleBlue;
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    RETableViewCellStyle *style = [[self class] allocWithZone:zone];
    if (style) {
        style.backgroundImages = [NSMutableDictionary dictionaryWithDictionary:[self.backgroundImages copyWithZone:zone]];
        style.selectedBackgroundImages = [NSMutableDictionary dictionaryWithDictionary:[self.selectedBackgroundImages copyWithZone:zone]];
        style.cellHeight = self.cellHeight;
        style.defaultCellSelectionStyle = self.defaultCellSelectionStyle;
        style.backgroundImageMargin = self.backgroundImageMargin;
        style.contentViewMargin = self.contentViewMargin;
    }
    return style;
}

- (BOOL)hasCustomBackgroundImage
{
    return [self backgroundImageForCellType:RETableViewCellTypeAny] || [self backgroundImageForCellType:RETableViewCellTypeFirst] || [self backgroundImageForCellType:RETableViewCellTypeMiddle] || [self backgroundImageForCellType:RETableViewCellTypeLast] || [self backgroundImageForCellType:RETableViewCellTypeSingle];
}

- (UIImage *)backgroundImageForCellType:(RETableViewCellType)cellType
{
    UIImage *image = [_backgroundImages objectForKey:@(cellType)];
    if (!image && cellType != RETableViewCellTypeAny)
        image = [_backgroundImages objectForKey:@(RETableViewCellTypeAny)];
    return image;
}

- (void)setBackgroundImage:(UIImage *)image forCellType:(RETableViewCellType)cellType
{
    if (image)
        [_backgroundImages setObject:image forKey:@(cellType)];
}

- (BOOL)hasCustomSelectedBackgroundImage
{
    return [self selectedBackgroundImageForCellType:RETableViewCellTypeAny] ||[self selectedBackgroundImageForCellType:RETableViewCellTypeFirst] || [self selectedBackgroundImageForCellType:RETableViewCellTypeMiddle] || [self selectedBackgroundImageForCellType:RETableViewCellTypeLast] || [self selectedBackgroundImageForCellType:RETableViewCellTypeSingle];
}

- (UIImage *)selectedBackgroundImageForCellType:(RETableViewCellType)cellType
{
    UIImage *image = [_selectedBackgroundImages objectForKey:@(cellType)];
    if (!image && cellType != RETableViewCellTypeAny)
        image = [_selectedBackgroundImages objectForKey:@(RETableViewCellTypeAny)];
    return image;
}

- (void)setSelectedBackgroundImage:(UIImage *)image forCellType:(RETableViewCellType)cellType
{
    if (image)
        [_selectedBackgroundImages setObject:image forKey:@(cellType)];
}

@end
