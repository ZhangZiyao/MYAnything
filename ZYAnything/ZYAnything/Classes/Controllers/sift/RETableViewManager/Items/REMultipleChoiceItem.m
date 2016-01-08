//
// REMultipleChoiceItem.m
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "REMultipleChoiceItem.h"

@implementation REMultipleChoiceItem

+ (instancetype)itemWithTitle:(NSString *)title value:(NSArray *)value selectionHandler:(void(^)(REMultipleChoiceItem *item))selectionHandler
{
    return [[self alloc] initWithTitle:title value:value selectionHandler:selectionHandler];
}

- (id)initWithTitle:(NSString *)title value:(NSArray *)value selectionHandler:(void(^)(REMultipleChoiceItem *item))selectionHandler
{
    self = [super init];
    if (!self)
        return nil;
    
    self.title = title;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionHandler = selectionHandler;
    self.value = value;
    self.style = UITableViewCellStyleValue1;
    
    return self;
}

- (void)setValue:(NSArray *)value
{
    _value = value;
    NSMutableString *values = [[NSMutableString alloc] init];
    
    if (value.count == 0)
    {
        self.detailLabelText = @"";
    }
    
    if (value.count == 1)
    {
        self.detailLabelText = [value objectAtIndex:0];
    }
    
    if (value.count > 1)
    {
        for (int i = 0; i < value.count; i++) {
            NSString *string;
            if (i == value.count-1) {
                string = [NSString stringWithFormat:@"%@",value[i]];
            }else{
                string = [NSString stringWithFormat:@"%@、",value[i]];
            }
            [values appendString:string];
            
        }
        if ([values length] >= 9) {
            NSString *str = [NSString stringWithFormat:@"%@...",[values substringToIndex:8]];
            self.detailLabelText = str;
            NSLog(@"detailLabelText11%@",self.detailLabelText);
        }else{
            self.detailLabelText = values;
            NSLog(@"detailLabelText22%@",self.detailLabelText);
        }
    }
}

@end
