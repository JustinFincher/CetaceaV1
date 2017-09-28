//
//  JZMarkdownListViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/30.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZMarkdownListViewController.h"
#import "JZiCloudStorageProcesser.h"
#import "JZMarkdownListTableCellView.h"
#import "DateTools.h"
#import "JZMarkdownListSortSelectionMenu.h"
#import <CetaceaSharedFramework/CSFCetaceaSharedDocument.h>

@interface JZMarkdownListViewController ()<NSTableViewDelegate,NSTableViewDataSource,JZiCloudStorageProcesserDelegate,JZMarkdownListSortSelectionMenuDelegate>
@property (weak) IBOutlet NSTableView *markdownListTableView;
@property (strong,nonatomic) NSMutableArray *markdownFileArray;
@property (strong,nonatomic) JZMarkdownListSortSelectionMenu* sortMenu;
@property (weak) IBOutlet NSButton *sortMenuButton;

@property (strong, nonatomic) NSMenu *markdownListTableViewCellMenu;
@end

@implementation JZMarkdownListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.markdownListTableView.delegate = self;
    self.markdownListTableView.dataSource = self;
    
    JZiCloudStorageProcesser *iCloudStorageProcesser = (JZiCloudStorageProcesser *)[JZiCloudStorageProcesser sharedManager];
    iCloudStorageProcesser.delegate = self;
    [JZiCloudStorageProcesser sharedManager];
    
    [self.markdownListTableView reloadData];
    
    self.markdownListTableViewCellMenu = [[NSMenu alloc] initWithTitle:@"Article Edit"];
    [self.markdownListTableViewCellMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Delete" action:@selector(articleEditDeleteMenuClicked:) keyEquivalent:@""]];
    self.markdownListTableView.menu = self.markdownListTableViewCellMenu;
}

#pragma mark - Article Edit Menu
- (void)articleEditDeleteMenuClicked:(id)sender
{
    NSInteger clickedRowIndex = self.markdownListTableView.clickedRow;
    CSFCetaceaAbstractSharedDocument *markdown = [self.markdownFileArray objectAtIndex:clickedRowIndex];
//    [markdown deleteCetaceDocument:^(BOOL isSuccessful)
//    {
//        [self.markdownListTableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:clickedRowIndex] withAnimation:NSTableViewAnimationSlideUp];
//        if (clickedRowIndex == self.markdownListTableView.selectedRow)
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"markdownListSelectionChanged" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys: nil, @"newValue" ,nil]];
//        }
//    }];
}


#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    JZMarkdownListTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if( [tableColumn.identifier isEqualToString:@"markdownColumn"] )
    {

    }
    CSFCetaceaAbstractSharedDocument *markdown = [self.markdownFileArray objectAtIndex:row];
    
    cellView.titleTextField.stringValue = markdown.title;
    if (markdown.markdownString)
    {
        cellView.contentTextField.stringValue = markdown.markdownString;
    }else
    {
        cellView.contentTextField.stringValue = @"";
    }
    
    if (markdown.lastChangeDate)
    {
        cellView.updateDateTextField.stringValue = markdown.lastChangeDate.timeAgoSinceNow;
    }
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    if (self.markdownFileArray)
        return [self.markdownFileArray count];
    else
        return 0;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 96;
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger row = [[notification object] selectedRow];
    if (row >= 0)
    {
        CSFCetaceaAbstractSharedDocument *markdown = [self.markdownFileArray objectAtIndex:row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"markdownListSelectionChanged" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:markdown, @"newValue" ,nil]];
        id<JZMarkdownListViewDelegate> strongDelegate = self.delegate;
        [strongDelegate rowSelected:markdown];
    }else
    {
        
    }
}


#pragma mark - JZiCloudStorageProcesserDelegate

- (void)iCloudFileProcessed:(NSMutableArray *)markdowns
{
    if (markdowns)
    {
        [self reloadDataWithMarkdowns:markdowns];
    }
}

- (void)reloadDataWithMarkdowns :(NSMutableArray *)markdowns
{
    if (self.markdownListTableView.selectedRow != -1)
    {
        CSFCetaceaAbstractSharedDocument *selectedDoc = (CSFCetaceaAbstractSharedDocument *)[self.markdownFileArray objectAtIndex:self.markdownListTableView.selectedRow];
        self.markdownFileArray = [self sortedArrayFrom:markdowns];
        [self.markdownListTableView reloadData];
        for (int i = 0; i < self.markdownFileArray.count; i++)
        {
            CSFCetaceaAbstractSharedDocument *a = [self.markdownFileArray objectAtIndex:i];
            if ([a isEqual:selectedDoc])
            {
                [self.markdownListTableView scrollRowToVisible:i];
                [self.markdownListTableView selectRow:i byExtendingSelection:NO];
            }
        }
    }else
    {
        self.markdownFileArray = [self sortedArrayFrom:markdowns];
        [self.markdownListTableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"markdownListSelectionChanged" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:nil, @"newValue" ,nil]];
    }
}

- (NSMutableArray *)sortedArrayFrom:(NSMutableArray *)icloudFileMarkdowns
{
    JZMarkdownListSortMethod method;
    JZMarkdownListSortDirection direction;
    
    NSString *MARKDOWN_LIST_SORT_METHOD = [[NSUserDefaults standardUserDefaults] valueForKey:@"MARKDOWN_LIST_SORT_METHOD"];
    if (!MARKDOWN_LIST_SORT_METHOD)
    {
        MARKDOWN_LIST_SORT_METHOD = @"JZMarkdownListSortMethodByEditDate";
        [[NSUserDefaults standardUserDefaults] setValue:MARKDOWN_LIST_SORT_METHOD forKey:@"MARKDOWN_LIST_SORT_METHOD"];
    }
    if ([MARKDOWN_LIST_SORT_METHOD isEqualToString:@"JZMarkdownListSortMethodByEditDate"])
    {
        method = JZMarkdownListSortMethodByEditDate;
    }else if ([MARKDOWN_LIST_SORT_METHOD isEqualToString:@"JZMarkdownListSortMethodByTitle"])
    {
        method = JZMarkdownListSortMethodByTitle;
    }
    
    NSString *MARKDOWN_LIST_SORT_DIRECTION = [[NSUserDefaults standardUserDefaults] valueForKey:@"MARKDOWN_LIST_SORT_DIRECTION"];
    if (!MARKDOWN_LIST_SORT_DIRECTION)
    {
        MARKDOWN_LIST_SORT_DIRECTION = @"JZMarkdownListSortDirectionDescending";
        [[NSUserDefaults standardUserDefaults] setValue:MARKDOWN_LIST_SORT_DIRECTION forKey:@"MARKDOWN_LIST_SORT_DIRECTION"];
    }
    if ([MARKDOWN_LIST_SORT_DIRECTION isEqualToString:@"JZMarkdownListSortDirectionAscending"])
    {
        direction = JZMarkdownListSortDirectionAscending;
    }else if ([MARKDOWN_LIST_SORT_DIRECTION isEqualToString:@"JZMarkdownListSortDirectionDescending"])
    {
        direction = JZMarkdownListSortDirectionDescending;
    }
    
    NSArray *sortedArray;
    sortedArray = [icloudFileMarkdowns sortedArrayUsingComparator:^NSComparisonResult(id a, id b)
    {
        switch (method)
        {
            case JZMarkdownListSortMethodByCreateDate:
            {
                NSDate *first = [(CSFCetaceaAbstractSharedDocument*)a lastChangeDate];
                NSDate *second = [(CSFCetaceaAbstractSharedDocument*)b lastChangeDate];
                switch (direction)
                {
                    case JZMarkdownListSortDirectionAscending:
                        return [first compare:second];
                        break;
                    case JZMarkdownListSortDirectionDescending:
                        return [second compare:first];
                        break;
                }
            }
                break;
            case JZMarkdownListSortMethodByEditDate:
            {
                NSDate *first = [(CSFCetaceaAbstractSharedDocument*)a lastChangeDate];
                NSDate *second = [(CSFCetaceaAbstractSharedDocument*)b lastChangeDate];
                switch (direction)
                {
                    case JZMarkdownListSortDirectionAscending:
                        return [first compare:second];
                        break;
                    case JZMarkdownListSortDirectionDescending:
                        return [second compare:first];
                        break;
                }
            }
                break;
            case JZMarkdownListSortMethodByTitle:
            {
                NSString *first = [(CSFCetaceaAbstractSharedDocument*)a title];
                NSString *second = [(CSFCetaceaAbstractSharedDocument*)b title];
                switch (direction)
                {
                    case JZMarkdownListSortDirectionAscending:
                        return [first compare:second];
                        break;
                    case JZMarkdownListSortDirectionDescending:
                        return [second compare:first];
                        break;
                }
            }
                break;
            default:
                break;
        }
    }];
    return (NSMutableArray *)sortedArray;
}

#pragma mark - Update List
- (IBAction)sortMenuButtonPressed:(NSButton *)sender
{
    if (!_sortMenu)
    {
        _sortMenu = [[JZMarkdownListSortSelectionMenu alloc]init];
    }
    _sortMenu.sortResultDelegate = self;
    [_sortMenu popUpMenuPositioningItem:nil atLocation:CGPointMake(sender.frame.size.width, 0) inView:sender];
}

#pragma mark - JZMarkdownListSortSelectionMenuDelegate
- (void)selectionChanged
{
    [self reloadDataWithMarkdowns:self.markdownFileArray];
}


@end
