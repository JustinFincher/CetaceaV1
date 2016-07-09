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
    
#warning this
    self.doc = [[JZiCloudFileExtensionCetaceaThemeDoc alloc] initWithDocPath:[[JZiCloudFileExtensionCetaceaThemeDataBase sharedManager] nextDocPath]];
    [self.tableView reloadData];
}
- (IBAction)comfirmButtonPressed:(id)sender {
}
- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewController:self];
}
#pragma mark - Static Data
+ (NSArray *)staticData
{
    static NSArray *_staticData;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        _staticData = @[
                        //Struct Section Header Row
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Struct",@"",@"",@""]
                            },
                        //AtxHeader Row
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"AtxHeader",@"###",@[@"",@"",@""],@[@"",@"",@""]]
                            }
                        ];
    });
    return _staticData;
}

#pragma mark - NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [[JZSettingsHighlightThemeEditViewController staticData] count];
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row
{
    NSDictionary *dict = [[JZSettingsHighlightThemeEditViewController staticData] objectAtIndex:row];
    NSArray* titlesArray = [dict valueForKey:@"SectionTitles"];
    if ([[dict valueForKey:@"isSectionHeaderRow"] isEqualToString:@"YES"])
    {
        NSString *cellIdentifer;
        //    NSView *cellView;
        
        //NSUInteger index = [[self.tableView tableColumns] indexOfObject:tableColumn];
        
        if (tableColumn == tableView.tableColumns[0])
        {
            cellIdentifer = @"tagSectionView";
            NSTableCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
            view.textField.stringValue = [titlesArray objectAtIndex:0];
            return view;
            
        }else if (tableColumn == tableView.tableColumns[1])
        {
            cellIdentifer = @"syntaxSectionView";
            NSTableCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
            view.textField.stringValue = [titlesArray objectAtIndex:1];
            return view;
        }
        else if (tableColumn == tableView.tableColumns[2])
        {
            cellIdentifer = @"lightThemeSectionView";
            NSTableCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
            view.textField.stringValue = [titlesArray objectAtIndex:2];
            return view;
        }
        else if (tableColumn == tableView.tableColumns[3])
        {
            cellIdentifer = @"darkThemeSectionView";
            NSTableCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
            view.textField.stringValue = [titlesArray objectAtIndex:3];
            return view;
        }
    }else
    {
        NSString *cellIdentifer;
        //    NSView *cellView;
        if (tableColumn == tableView.tableColumns[0])
        {
            cellIdentifer = @"tagCellView";
            JZSettingsApperanceThemeTableViewTagCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
            view.tagNameTextfield.stringValue = [titlesArray objectAtIndex:0];
            return view;
            
        }else if (tableColumn == tableView.tableColumns[1])
        {
            cellIdentifer = @"syntaxCellView";
            JZSettingsApperanceThemeTableViewSyntaxCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
            view.syntaxExampleTextfield.stringValue = [titlesArray objectAtIndex:1];
            return view;
        }
        else if (tableColumn == tableView.tableColumns[2])
        {
            cellIdentifer = @"lightThemeCellView";
            JZSettingsApperanceThemeTableViewLightCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
            return view;
        }
        else if (tableColumn == tableView.tableColumns[3])
        {
            cellIdentifer = @"darkThemeCellView";
            JZSettingsApperanceThemeTableViewDarkCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
            return view;
        }
    }
    return nil;
        
}
- (CGFloat)tableView:(NSTableView *)tableView
         heightOfRow:(NSInteger)row
{
    NSDictionary *dict = [[JZSettingsHighlightThemeEditViewController staticData] objectAtIndex:row];
    if ([[dict valueForKey:@"isSectionHeaderRow"] isEqualToString:@"YES"])
    {
        return 20.0f;
    }
    else
    {
        return 30.0f;
    }
}

-(BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row
{
    return NO;
}


@end
