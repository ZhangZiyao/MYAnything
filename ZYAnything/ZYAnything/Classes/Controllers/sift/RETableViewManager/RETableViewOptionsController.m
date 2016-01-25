//
// RETableViewOptionsController.m
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
#import "RETableViewOptionsController.h"
#import "RETableViewItem.h"
#import "RETableViewManager.h"
#import "UIDefines.h"

@interface RETableViewOptionsController ()

@end

@implementation RETableViewOptionsController

- (id)initWithItem:(RETableViewItem *)item options:(NSArray *)options multipleChoice:(BOOL)multipleChoice completionHandler:(void(^)(void))completionHandler
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self)
        return nil;
    
    self.item = item;
    self.options = options;
    self.title = item.title;
    self.multipleChoice = multipleChoice;
    self.completionHandler = completionHandler;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBack:@selector(backAction)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.tableView.backgroundColor = [UIColor clearColor];

    _tableViewManager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self.delegate];
    _mainSection = [[RETableViewSection alloc] init];
    _mainSection.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, 0.01)];
    _mainSection.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, 0.01)];
    
    [_tableViewManager addSection:_mainSection];
    
    if (self.style)
        _tableViewManager.style = self.style;
    
    __typeof (&*self) __weak weakSelf = self;
    void (^refreshItems)(void) = ^{
        REMultipleChoiceItem * __weak item = (REMultipleChoiceItem *)weakSelf.item;
        NSMutableArray *results = [[NSMutableArray alloc] init];
        for (RETableViewItem *sectionItem in weakSelf.mainSection.items) {
            for (NSString *strValue in item.value) {
                if ([strValue isEqualToString:sectionItem.title])
                    [results addObject:sectionItem.title];
            }
        }
        item.value = results;
    };
    
    void (^addItem)(NSString *title) = ^(NSString *title) {
        UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
        if (!weakSelf.multipleChoice) {
            if ([title isEqualToString:self.item.detailLabelText])
                accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            REMultipleChoiceItem * __weak item = (REMultipleChoiceItem *)weakSelf.item;
            for (NSString *strValue in item.value) {
                if ([strValue isEqualToString:title]) {
                    accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
        }
        [_mainSection addItem:[RETableViewItem itemWithTitle:title accessoryType:accessoryType selectionHandler:^(RETableViewItem *selectedItem) {
            UITableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:selectedItem.indexPath];
            if (!weakSelf.multipleChoice) {
                for (NSIndexPath *indexPath in [weakSelf.tableView indexPathsForVisibleRows]) {
                    UITableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                for (RETableViewItem *item in weakSelf.mainSection.items) {
                    item.accessoryType = UITableViewCellAccessoryNone;
                }
                selectedItem.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                RERadioItem * __weak item = (RERadioItem *)weakSelf.item;
                item.value = selectedItem.title;
                if (weakSelf.completionHandler)
                    weakSelf.completionHandler();
            } else { // Multiple choice item
                REMultipleChoiceItem * __weak item = (REMultipleChoiceItem *)weakSelf.item;
                [weakSelf.tableView deselectRowAtIndexPath:selectedItem.indexPath animated:YES];
                if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    NSMutableArray *items = [[NSMutableArray alloc] init];
                    for (NSString *val in item.value) {
                        if (![val isEqualToString:selectedItem.title])
                            [items addObject:val];
                    }
                    
                    item.value = items;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:item.value];
                    [items addObject:selectedItem.title];
                    item.value = items;
                    refreshItems();
                }
                if (weakSelf.completionHandler)
                    weakSelf.completionHandler();
            }
        }]];
    };
    
    for (RETableViewItem *item in self.options) {
        addItem([item isKindOfClass:[[RERadioItem item] class]] ? item.title : (NSString *)item);
    }
}

@end
