//
// RETableViewCell.h
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
#import <UIKit/UIKit.h>
#import "RETableViewSection.h"

@class RETableViewManager;
@class RETableViewItem;

typedef NS_ENUM(NSInteger, RETableViewCellType) {
    RETableViewCellTypeFirst,
    RETableViewCellTypeMiddle,
    RETableViewCellTypeLast,
    RETableViewCellTypeSingle,
    RETableViewCellTypeAny
};

/**
 The `RETableViewCell` class defines the attributes and behavior of the cells that appear in `UITableView` objects.
 
 */
@interface RETableViewCell : UITableViewCell

///-----------------------------
/// @name Accessing Table View and Table View Manager
///-----------------------------

@property (weak, readwrite, nonatomic) UITableView *parentTableView;
@property (weak, readwrite, nonatomic) RETableViewManager *tableViewManager;

///-----------------------------
/// @name Managing Cell Height
///-----------------------------

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager;

///-----------------------------
/// @name Working With Keyboard
///-----------------------------

+ (BOOL)canFocusWithItem:(RETableViewItem *)item;

@property (strong, readonly, nonatomic) UIResponder *responder;
@property (strong, readonly, nonatomic) NSIndexPath *indexPathForPreviousResponder;
@property (strong, readonly, nonatomic) NSIndexPath *indexPathForNextResponder;

///-----------------------------
/// @name Managing Cell Appearance
///-----------------------------

@property (strong, readonly, nonatomic) UIImageView *backgroundImageView;
@property (strong, readonly, nonatomic) UIImageView *selectedBackgroundImageView;

- (void)layoutDetailView:(UIView *)view minimumWidth:(CGFloat)minimumWidth;

///-----------------------------
/// @name Accessing Row and Section
///-----------------------------

@property (assign, readwrite, nonatomic) NSInteger rowIndex;
@property (assign, readwrite, nonatomic) NSInteger sectionIndex;
@property (weak, readwrite, nonatomic) RETableViewSection *section;
@property (strong, readwrite, nonatomic) RETableViewItem *item;
@property (assign, readonly, nonatomic) RETableViewCellType type;

///-----------------------------
/// @name Handling Cell Events
///-----------------------------

- (void)cellDidLoad;
- (void)cellWillAppear;
- (void)cellDidDisappear;

@property (assign, readonly, nonatomic) BOOL loaded;

@end
