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


@interface JZMarkdownListViewController ()<NSTableViewDelegate,NSTableViewDataSource,JZiCloudStorageProcesserDelegate>
@property (weak) IBOutlet NSTableView *markdownListTableView;

@property (strong,nonatomic) NSMutableArray *markdownFileArray;

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
//    NSLog(@"self.markdownListTableView.numberOfRows %ld",(long)self.markdownListTableView.numberOfRows);
//    if (self.markdownListTableView.numberOfRows > 0)
//    {
//        [self.markdownListTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:1] byExtendingSelection:NO];
//    }
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    JZMarkdownListTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if( [tableColumn.identifier isEqualToString:@"markdownColumn"] )
    {

    }
    JZiCloudMarkdownFileModel *markdown = [self.markdownFileArray objectAtIndex:row];
    cellView.titleTextField.stringValue = [markdown.url lastPathComponent];
    if (markdown.previewString)
    {
        cellView.contentTextField.stringValue = markdown.previewString;
    }else
    {
        cellView.contentTextField.stringValue = @"";
    }
    cellView.markdownReference = markdown;
    
    cellView.updateDateTextField.stringValue = markdown.updatedDate.timeAgoSinceNow;
    return cellView;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
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
    JZMarkdownListTableCellView *selectedRow = [self.markdownListTableView viewAtColumn:0 row:[[notification object] selectedRow] makeIfNecessary:YES];
    //NSLog(@"%@",selectedRow.markdownReference.previewString);
    
    id<JZMarkdownListViewDelegate> strongDelegate = self.delegate;
    [strongDelegate rowSelected:selectedRow.markdownReference];
}
#pragma mark - JZiCloudStorageProcesserDelegate

- (void)iCloudFileProcessed:(NSMutableArray *)markdowns
{
    if (markdowns)
    {
        self.markdownFileArray = markdowns;
        [self.markdownListTableView reloadData];
    }
}

@end
