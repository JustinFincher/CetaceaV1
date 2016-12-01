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
#import "JZHeader.h"

@interface JZMarkdownListViewController ()<NSTableViewDelegate,NSTableViewDataSource,JZiCloudStorageProcesserDelegate,JZMarkdownListSortSelectionMenuDelegate>
@property (weak) IBOutlet NSTableView *markdownListTableView;
@property (strong,nonatomic) NSMutableArray *markdownFileArray;
@property (strong,nonatomic) JZMarkdownListSortSelectionMenu* sortMenu;
@property (weak) IBOutlet NSButton *sortMenuButton;


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
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    JZMarkdownListTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if( [tableColumn.identifier isEqualToString:@"markdownColumn"] )
    {

    }
    JZiCloudFileExtensionCetaceaDocument *markdown = [self.markdownFileArray objectAtIndex:row];
    
    cellView.titleTextField.stringValue = markdown.title;
    if (markdown.highLightString)
    {
        cellView.contentTextField.attributedStringValue = markdown.highLightString;
    }else
    {
        cellView.contentTextField.stringValue = @"";
    }
    cellView.markdownDocReference = markdown;
    
    cellView.updateDateTextField.stringValue = markdown.fileModificationDate.timeAgoSinceNow;
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
    if ([[notification object] selectedRow] >= 0)
    {
        JZMarkdownListTableCellView *selectedRow = [self.markdownListTableView viewAtColumn:0 row:[[notification object] selectedRow] makeIfNecessary:YES];
        id<JZMarkdownListViewDelegate> strongDelegate = self.delegate;
        [strongDelegate rowSelected:selectedRow.markdownDocReference];
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
        NSString *selectedDocPath = [[(JZiCloudFileExtensionCetaceaDocument *)[self.markdownFileArray objectAtIndex:self.markdownListTableView.selectedRow] fileURL] absoluteString];
        self.markdownFileArray = [self sortedArrayFrom:markdowns];
        [self.markdownListTableView reloadData];
        for (int i = 0; i < self.markdownFileArray.count; i++)
        {
            JZiCloudFileExtensionCetaceaDocument *a = [self.markdownFileArray objectAtIndex:i];
            if ([[[a fileURL]absoluteString] isEqualToString:selectedDocPath])
            {
                [self.markdownListTableView scrollRowToVisible:i];
                [self.markdownListTableView selectRow:i byExtendingSelection:NO];
            }
        }
    }else
    {
        self.markdownFileArray = [self sortedArrayFrom:markdowns];
        [self.markdownListTableView reloadData];
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
                NSDate *first = [(JZiCloudFileExtensionCetaceaDocument*)a fileModificationDate];
                NSDate *second = [(JZiCloudFileExtensionCetaceaDocument*)b fileModificationDate];
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
                NSDate *first = [(JZiCloudFileExtensionCetaceaDocument*)a fileModificationDate];
                NSDate *second = [(JZiCloudFileExtensionCetaceaDocument*)b fileModificationDate];
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
                NSString *first = [(JZiCloudFileExtensionCetaceaDocument*)a title];
                NSString *second = [(JZiCloudFileExtensionCetaceaDocument*)b title];
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
//    self.markdownFileArray = [self sortedArrayFrom:self.markdownFileArray];
    [self reloadDataWithMarkdowns:self.markdownFileArray];
}


@end
