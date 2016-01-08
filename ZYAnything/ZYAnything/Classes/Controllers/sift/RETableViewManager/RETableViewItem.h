//
// RETableViewItem.h
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
#import <Foundation/Foundation.h>
#import "RETableViewCellStyle.h"

@class RETableViewSection;

@interface RETableViewItem : NSObject

@property (copy, readwrite, nonatomic) NSString *title;
@property (strong, readwrite, nonatomic) UIImage *image;
@property (strong, readwrite, nonatomic) UIImage *highlightedImage;
@property (assign, readwrite, nonatomic) NSTextAlignment textAlignment;
@property (weak, readwrite, nonatomic) RETableViewSection *section;
@property (copy, readwrite, nonatomic) NSString *detailLabelText;
@property (assign, readwrite, nonatomic) UITableViewCellStyle style;
@property (assign, readwrite, nonatomic) UITableViewCellSelectionStyle selectionStyle;
@property (assign, readwrite, nonatomic) UITableViewCellAccessoryType accessoryType;
@property (assign, readwrite, nonatomic) UITableViewCellEditingStyle editingStyle;
@property (strong, readwrite, nonatomic) UIView *accessoryView;
@property (copy, readwrite, nonatomic) void (^selectionHandler)(id item);
@property (copy, readwrite, nonatomic) void (^accessoryButtonTapHandler)(id item);
@property (copy, readwrite, nonatomic) void (^insertionHandler)(id item);
@property (copy, readwrite, nonatomic) void (^deletionHandler)(id item);
@property (copy, readwrite, nonatomic) void (^deletionHandlerWithCompletion)(id item, void (^)(void));
@property (copy, readwrite, nonatomic) BOOL (^moveHandler)(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
@property (copy, readwrite, nonatomic) void (^moveCompletionHandler)(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
@property (copy, readwrite, nonatomic) void (^cutHandler)(id item);
@property (copy, readwrite, nonatomic) void (^copyHandler)(id item);
@property (copy, readwrite, nonatomic) void (^pasteHandler)(id item);
@property (assign, readwrite, nonatomic) CGFloat cellHeight;
@property (copy, readwrite, nonatomic) NSString *cellIdentifier;

// Error validation
//
@property (copy, readwrite, nonatomic) NSString *name;
@property (strong, readwrite, nonatomic) NSArray *validators;
@property (strong, readonly, nonatomic) NSArray *errors;

+ (instancetype)item;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler;
+ (instancetype)itemWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler accessoryButtonTapHandler:(void(^)(RETableViewItem *item))accessoryButtonTapHandler;

- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler;
- (id)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler accessoryButtonTapHandler:(void(^)(RETableViewItem *item))accessoryButtonTapHandler;

- (NSIndexPath *)indexPath;

///-----------------------------
/// @name Manipulating table view row
///-----------------------------

- (void)selectRowAnimated:(BOOL)animated;
- (void)selectRowAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)deselectRowAnimated:(BOOL)animated;
- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation;

@end
