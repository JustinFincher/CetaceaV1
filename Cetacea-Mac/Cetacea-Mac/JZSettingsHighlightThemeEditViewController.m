//
//  JZSettingsHighlightThemeEditViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZSettingsHighlightThemeEditViewController.h"

#import "JZSettingsApperanceThemeTableViewLightCellView.h"
#import "JZSettingsApperanceThemeTableViewTagCellView.h"
#import "JZSettingsApperanceThemeTableViewDarkCellView.h"
#import "JZSettingsApperanceThemeTableViewSyntaxCellView.h"

@interface JZSettingsHighlightThemeEditViewController ()<NSTableViewDelegate,NSTableViewDataSource>
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation JZSettingsHighlightThemeEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (IBAction)comfirmButtonPressed:(id)sender {
}
- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewController:self];
}

#pragma mark - NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return 3;
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row
{
    NSString *cellIdentifer;
//    NSView *cellView;
    if (tableColumn == tableView.tableColumns[0])
    {
        cellIdentifer = @"tagCellView";
        JZSettingsApperanceThemeTableViewTagCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
        return view;
        
    }else if (tableColumn == tableView.tableColumns[1])
    {
        cellIdentifer = @"syntaxCellView";
        JZSettingsApperanceThemeTableViewTagCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
        return view;
    }
    else if (tableColumn == tableView.tableColumns[2])
    {
        cellIdentifer = @"lightThemeCellView";
        JZSettingsApperanceThemeTableViewTagCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
        return view;
    }
    else if (tableColumn == tableView.tableColumns[3])
    {
        cellIdentifer = @"darkThemeCellView";
        JZSettingsApperanceThemeTableViewTagCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
        return view;
    }
    return nil;
        
}
- (CGFloat)tableView:(NSTableView *)tableView
         heightOfRow:(NSInteger)row
{
    return 40.0f;
}
@end
