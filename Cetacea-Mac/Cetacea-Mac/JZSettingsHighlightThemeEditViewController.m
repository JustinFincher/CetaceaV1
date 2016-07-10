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
#import "KeyValueObserver.h"

@interface JZSettingsHighlightThemeEditViewController ()<NSTableViewDelegate,NSTableViewDataSource>
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic, strong) id themeObserveToken;

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
                            @"SectionTitles" : @[@"Structure",@"",@"",@""]
                        },
                        //AtxHeader Row
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Atx Header",@"# level 1 header\n## level 2 header\n### level 3 header\n#### level 4 header\n##### level 5 header\n###### level 6 header",@[@"",@"",@""],@[@"",@"",@""]],
                            @"DataModel" : @"AtxHeaderDataModel"
                        },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Setext Header",@"level 1 header\n--------------\nlevel 2 header\n==============",@[@"",@"",@""],@[@"",@"",@""]],
                            @"DataModel" : @"SetextHeaderDataModel"
                        },
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Paragraph",@"",@"",@""]
                        },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Code Block",@"`code`\nOR\n```\ncode\n```",@[@"",@"",@""],@[@"",@"",@""]],
                            @"DataModel" : @"CodeBlockDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Tab Indent",@"(tab)text",@[@"",@"",@""],@[@"",@"",@""]]
                            },
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Text",@"",@"",@""]
                        },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Bold",@"**bold**",@[@"",@"",@""],@[@"",@"",@""]]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Italic",@"*Italic*",@[@"",@"",@""],@[@"",@"",@""]]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Strike Through",@"~~text~~",@[@"",@"",@""],@[@"",@"",@""]]
                            },
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Group",@"",@"",@""]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"List",@"+ list\nOR\n- list\nOR\n* list",@[@"",@"",@""],@[@"",@"",@""]]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Quote",@"> Quote",@[@"",@"",@""],@[@"",@"",@""]]
                            },
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Link",@"",@"",@""]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Image",@"![img name](img path)",@[@"",@"",@""],@[@"",@"",@""]]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Link",@"[link name](link path)",@[@"",@"",@""],@[@"",@"",@""]]
                            },
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Editor View",@"",@"",@""]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Background",@"editor's background view",@[@"",@"",@""],@[@"",@"",@""]]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Line Indicator",@"editor's sidebar view",@[@"",@"",@""],@[@"",@"",@""]]
                            },
                        
                        ];
    });
    return _staticData;
}

#pragma mark - KVO Stuff
- (void)setDoc:(JZiCloudFileExtensionCetaceaThemeDoc *)doc
{
    _doc = doc;
    self.themeObserveToken = [KeyValueObserver observeObject:doc
                                                     keyPath:@"data"
                                                      target:self
                                                    selector:@selector(themeDataDidChange:)
                                                     options:NSKeyValueObservingOptionInitial];
}

- (void)themeDataDidChange:(NSDictionary *)change;
{
    
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
        
        NSDictionary *dict = [[JZSettingsHighlightThemeEditViewController staticData] objectAtIndex:row];
        NSArray* titlesArray = [dict valueForKey:@"SectionTitles"];
        NSString *exampleString = [titlesArray objectAtIndex:1];
        NSInteger length = [[exampleString componentsSeparatedByCharactersInSet:
                             [NSCharacterSet newlineCharacterSet]] count];
        CGFloat height = length * 15.0f;
        return (height > 30.0f)? height : 30.0f;
    }
}

-(BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row
{
    return NO;
}


@end
