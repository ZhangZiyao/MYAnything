//
// RETableViewOptionsController.h
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"

@interface RETableViewOptionsController : UITableViewController <RETableViewManagerDelegate>

@property (weak, readwrite, nonatomic) RETableViewItem *item;
@property (strong, readwrite, nonatomic) NSArray *options;
@property (strong, readonly, nonatomic) RETableViewManager *tableViewManager;
@property (strong, readonly, nonatomic) RETableViewSection *mainSection;
@property (assign, readwrite, nonatomic) BOOL multipleChoice;
@property (copy, readwrite, nonatomic) void (^completionHandler)(void);
@property (strong, readwrite, nonatomic) RETableViewCellStyle *style;
@property (weak, readwrite, nonatomic) id<RETableViewManagerDelegate> delegate;

- (id)initWithItem:(RETableViewItem *)item options:(NSArray *)options multipleChoice:(BOOL)multipleChoice completionHandler:(void(^)(void))completionHandler;

@end
