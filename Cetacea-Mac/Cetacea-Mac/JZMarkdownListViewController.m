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
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    JZMarkdownListTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if( [tableColumn.identifier isEqualToString:@"markdownColumn"] )
    {

    }
    JZiCloudFileExtensionCetaceaDoc *markdown = [self.markdownFileArray objectAtIndex:row];
    
    NSImage *img = [markdown.data.isFavorite boolValue] ? [NSImage imageNamed:@"JZStarFilledTemplate"] : [NSImage imageNamed:@"JZStarNotFilledTemplate"];
    cellView.isStarredImageView.image = img;
    cellView.titleTextField.stringValue = [markdown getData].title;
    if ([markdown getData].highLightString)
    {
        cellView.contentTextField.attributedStringValue = markdown.data.highLightString;
    }else
    {
        cellView.contentTextField.stringValue = @"";
    }
    cellView.markdownDocReference = markdown;
    
    cellView.updateDateTextField.stringValue = [markdown getData].updateDate.timeAgoSinceNow;
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
        self.markdownFileArray = markdowns;
        [self.markdownListTableView reloadData];
    }
}

@end
