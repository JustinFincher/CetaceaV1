//
//  JZSettingsHighlightThemeEditViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//
#import "JZHeader.h"
#import "JZSettingsHighlightThemeEditViewController.h"

#import "JZSettingsApperanceThemeTableViewLightCellView.h"
#import "JZSettingsApperanceThemeTableViewTagCellView.h"
#import "JZSettingsApperanceThemeTableViewDarkCellView.h"
#import "JZSettingsApperanceThemeTableViewSyntaxCellView.h"
#import "JZEditorHighlightThemeSingleRowDataModel.h"
#import "JZdayNightThemeManager.h"

#import "JZEditorHighlightThemeManager.h"
#import "JZEditorTextView.h"
#import "JZEditorMarkdownTextParserWithTSBaseParser.h"

@interface JZSettingsHighlightThemeEditViewController ()<NSTableViewDelegate,NSTableViewDataSource,NSTextFieldDelegate>
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSTextField *themeNameTextField;
@property (unsafe_unretained) IBOutlet JZEditorTextView *previewTextView;

@end

@implementation JZSettingsHighlightThemeEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.themeNameTextField.delegate = self;
    if (self.doc)
    {
        self.themeNameTextField.stringValue = self.doc.data.themeName;
        [self.previewTextView setString:JZ_MARKDOWN_SAMPLE_TEXT];
        [self.tableView reloadData];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorInThemeFileChanged:) name:JZ_NOTIFICATION_HIGHLIGHT_THEME_COLOR_CHANGED object:nil];
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    if (self.doc == nil)
    {
        self.doc = [[JZiCloudFileExtensionCetaceaThemeDoc alloc] initWithDocPath:[[JZiCloudFileExtensionCetaceaThemeDataBase sharedManager] nextDocPath]];
        [self.tableView reloadData];
    }
    [self updatePreviewHighlight];
}

- (void)colorInThemeFileChanged:(NSNotification *)notif
{
    if (self.doc)
    {
        [self.doc saveData];
        [self updatePreviewHighlight];
    }
}
- (void)updatePreviewHighlight
{
    if (self.previewTextView.parser == nil)
    {
        self.previewTextView.parser = [[JZEditorMarkdownTextParserWithTSBaseParser alloc] init];
    }
    self.previewTextView.parser.themeDoc = self.doc;
    [self.previewTextView.parser refreshAttributesTheme];
    [self.previewTextView refreshHightLight];
}
- (IBAction)comfirmnUseButtonPressed:(NSButton *)sender
{
    if (self.doc)
    {
        [[JZEditorHighlightThemeManager sharedManager] setSelectedDoc:self.doc];
        [self dismissViewController:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"themeChangedOnHighLightEditView" object:self.doc userInfo:nil];
    }
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
                            @"SectionTitles" : @[@"Atx Header",@"# level 1 header\n## level 2 header\n### level 3 header\n#### level 4 header\n##### level 5 header\n###### level 6 header",@[@"Header Tag Color",@"Header Text Color",@"Header Background Color"],@[@"Header Tag Color",@"Header Text Color",@"Header Background Color"]],
                            @"DataModel" : @"AtxHeaderDataModel"
                        },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Setext Header",@"level 1 header\n--------------\nlevel 2 header\n==============",@[@"Header Tag Color",@"Header Text Color",@"Header Background Color"],@[@"Header Tag Color",@"Header Text Color",@"Header Background Color"]],
                            @"DataModel" : @"SetextHeaderDataModel"
                        },
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Paragraph",@"",@"",@""]
                        },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Code Block",@"`code`\nOR\n```\ncode\n```",@[@"Code Block Tag Color",@"Code Block Text Color",@"Code Block Background Color"],@[@"Code Block Tag Color",@"Code Block Text Color",@"Code Block Background Color"]],
                            @"DataModel" : @"CodeBlockDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Tab Indent",@"(tab)text",@[@"Tab Indent Tag Color",@"Tab Indent Text Color",@"Tab Indent Background Color"],@[@"Tab Indent Tag Color",@"Tab Indent Text Color",@"Tab Indent Background Color"]],
                            @"DataModel" : @"TabIndentDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Text",@"",@"",@""]
                        },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Defalut",@"(blank)",@[@"Default Tag Color",@"Default Text Color",@"Default Background Color"],@[@"Default Tag Color",@"Default Text Color",@"Default Background Color"]],
                            @"DataModel" : @"DefaultDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Bold",@"**bold**",@[@"Bold Tag Color",@"Bold Text Color",@"Bold Background Color"],@[@"Bold Tag Color",@"Bold Text Color",@"Bold Background Color"]],
                            @"DataModel" : @"BoldDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Italic",@"*Italic*",@[@"Italic Tag Color",@"Italic Text Color",@"Italic Background Color"],@[@"Italic Tag Color",@"Italic Text Color",@"Italic Background Color"]],
                            @"DataModel" : @"ItalicDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Strike Through",@"~~text~~",@[@"Strike Through Tag Color",@"Strike Through Text Color",@"Strike Through Background Color"],@[@"Strike Through Tag Color",@"Strike Through Text Color",@"Strike Through Background Color"]],
                            @"DataModel" : @"StrikeThroughDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Group",@"",@"",@""]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"List",@"+ list\nOR\n- list\nOR\n* list",@[@"List Tag Color",@"List Text Color",@"List Background Color"],@[@"List Tag Color",@"List Text Color",@"List Background Color"]],
                            @"DataModel" : @"ListDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Quote",@"> Quote",@[@"Quote Tag Color",@"Quote Text Color",@"Quote Background Color"],@[@"Quote Tag Color",@"Quote Text Color",@"Quote Background Color"]],
                            @"DataModel" : @"QuoteDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Link",@"",@"",@""]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Image",@"![img name](img path)",@[@"Image Tag Color",@"Image Text Color",@"Image Background Color"],@[@"Image Tag Color",@"Image Text Color",@"Image Background Color"]],
                            @"DataModel" : @"ImageDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Link",@"[link name](link path)",@[@"Link Tag Color",@"Link Text Color",@"Link Background Color"],@[@"Link Tag Color",@"Link Text Color",@"Link Background Color"]],
                            @"DataModel" : @"LinkDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"YES",
                            @"SectionTitles" : @[@"Editor View",@"",@"",@""]
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Background",@"editor's background view",@[@"Background Tag Color",@"Background Text Color",@"Background Color"],@[@"Background Tag Color",@"Background Text Color",@"Background Color"]],
                            @"DataModel" : @"EditorViewDataModel"
                            },
                        @{
                            @"isSectionHeaderRow": @"NO",
                            @"SectionTitles" : @[@"Line Indicator",@"editor's sidebar view",@[@"Line Indicator HighLight Color",@"Line Indicator Text Color",@"Line Indicator Background Color"],@[@"Line Indicator HighLight Color",@"Line Indicator Text Color",@"Line Indicator Background Color"]],
                            @"DataModel" : @"RuleViewDataModel"
                            },
                        
                        ];
    });
    return _staticData;
}

#pragma mark - KVO Stuff
- (void)setDoc:(JZiCloudFileExtensionCetaceaThemeDoc *)doc
{
    _doc = doc;
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
        NSString* dataModelStr = [dict valueForKey:@"DataModel"];
        JZEditorHighlightThemeSingleRowDataModel *dataModel = [self.doc.data valueForKey:dataModelStr];
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
            NSArray *descrptionArray = [titlesArray objectAtIndex:2];
            JZSettingsApperanceThemeTableViewLightCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
            [view.foregroundTagColorWell setColor:[dataModel.lightForegroundTagtColor color]];
            [view.foregroundTextColorWell setColor:[dataModel.lightForegroundTextColor color]];
            [view.backgroundBlockColorWell setColor:[dataModel.lightBackgroundBlockColor color]];
            view.foregroundTagColorWell.colorData = dataModel.lightForegroundTagtColor;
            view.foregroundTextColorWell.colorData = dataModel.lightForegroundTextColor;
            view.backgroundBlockColorWell.colorData = dataModel.lightBackgroundBlockColor;
            view.foregroundTagColorWell.labelString = [descrptionArray objectAtIndex:0];
            view.foregroundTextColorWell.labelString = [descrptionArray objectAtIndex:1];
            view.backgroundBlockColorWell.labelString = [descrptionArray objectAtIndex:2];
            return view;
        }
        else if (tableColumn == tableView.tableColumns[3])
        {
            cellIdentifer = @"darkThemeCellView";
            JZSettingsApperanceThemeTableViewDarkCellView *view = [self.tableView makeViewWithIdentifier:cellIdentifer owner:nil];
            [view.foregroundTagColorWell setColor:[dataModel.darkForegroundTagtColor color]];
            [view.foregroundTextColorWell setColor:[dataModel.darkForegroundTextColor color]];
            [view.backgroundBlockColorWell setColor:[dataModel.darkBackgroundBlockColor color]];
            view.foregroundTagColorWell.colorData = dataModel.darkForegroundTagtColor;
            view.foregroundTextColorWell.colorData = dataModel.darkForegroundTextColor;
            view.backgroundBlockColorWell.colorData = dataModel.darkBackgroundBlockColor;
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

#pragma mark - NSTextFieldDelegate
- (void)controlTextDidChange:(NSNotification *)obj
{
    NSTextField *field = [obj object];
    self.doc.data.themeName = [field stringValue];
}


@end
