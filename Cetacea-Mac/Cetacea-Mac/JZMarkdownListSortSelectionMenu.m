//
//  JZMarkdownListSortSelectionMenu.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/8/14.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZMarkdownListSortSelectionMenu.h"

@implementation JZMarkdownListSortSelectionMenu

- (id) init
{
    self = [super init];
    if (self)
    {
        _byEditDateItem = [[NSMenuItem alloc] initWithTitle:@"By Edit Date" action:@selector(setByEditDate) keyEquivalent:@"d"];
        _byTitleItem = [[NSMenuItem alloc] initWithTitle:@"By Title" action:@selector(setByTitle) keyEquivalent:@"t"];
        _byAscending = [[NSMenuItem alloc] initWithTitle:@"Ascending" action:@selector(setByAscending) keyEquivalent:@"a"];
        [_byAscending setKeyEquivalentModifierMask:NSShiftKeyMask];
        _byDescending = [[NSMenuItem alloc] initWithTitle:@"Descending" action:@selector(setByDescending) keyEquivalent:@"d"];
        [_byDescending setKeyEquivalentModifierMask:NSShiftKeyMask];
        
        _byEditDateItem.target = self;
        _byTitleItem.target = self;
        _byAscending.target = self;
        _byDescending.target = self;
        
        
        [self addItem:_byEditDateItem];
        [self addItem:_byTitleItem];
        [self addItem:[NSMenuItem separatorItem]];
        [self addItem:_byAscending];
        [self addItem:_byDescending];

    }
    return self;
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
    return [menuItem isEnabled];
}

- (void)setByEditDate
{
    [_byEditDateItem setState:NSOnState];
    [_byTitleItem setState:NSOffState];
    _sortMethod = JZMarkdownListSortMethodByEditDate;
    [[NSUserDefaults standardUserDefaults] setValue:@"JZMarkdownListSortMethodByEditDate" forKey:@"MARKDOWN_LIST_SORT_METHOD"];
}
- (void)setByTitle
{
    [_byEditDateItem setState:NSOffState];
    [_byTitleItem setState:NSOnState];
    _sortMethod = JZMarkdownListSortMethodByTitle;
    [[NSUserDefaults standardUserDefaults] setValue:@"JZMarkdownListSortMethodByTitle" forKey:@"MARKDOWN_LIST_SORT_METHOD"];
}
- (void)setByAscending
{
    [_byDescending setState:NSOffState];
    [_byAscending setState:NSOnState];
    _sortDirection = JZMarkdownListSortDirectionAscending;
    [[NSUserDefaults standardUserDefaults] setValue:@"JZMarkdownListSortDirectionAscending" forKey:@"MARKDOWN_LIST_SORT_DIRECTION"];
}
- (void)setByDescending
{
    [_byDescending setState:NSOnState];
    [_byAscending setState:NSOffState];
    _sortDirection = JZMarkdownListSortDirectionDescending;
    [[NSUserDefaults standardUserDefaults] setValue:@"JZMarkdownListSortDirectionDescending" forKey:@"MARKDOWN_LIST_SORT_DIRECTION"];
}

- (void) sortSelectionChangedWithMethod:(JZMarkdownListSortMethod)sortMethod
                              Direction:(JZMarkdownListSortDirection)sortDirection
{
    id<JZMarkdownListSortSelectionMenuDelegate> strongDelegate = self.sortResultDelegate;
    [strongDelegate selectionChangedWithMethod:sortMethod Direction:sortDirection];

}
@end
