//
//  JZMarkdownListViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/30.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZMarkdownListViewController.h"
#import "JZiCloudStorageManager.h"

@interface JZMarkdownListViewController ()<NSTableViewDelegate,NSTableViewDataSource,JZiCloudStorageManagerDelegate>
@property (weak) IBOutlet NSTableView *markdownListTableView;

@property (strong,nonatomic) NSMutableArray *markdownFileArray;

@end

@implementation JZMarkdownListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.markdownListTableView.delegate = self;
    self.markdownListTableView.dataSource = self;
    
    JZiCloudStorageManager *iCloudStorageManager = (JZiCloudStorageManager *)[JZiCloudStorageManager sharedManager];
    iCloudStorageManager.delegate = self;
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if( [tableColumn.identifier isEqualToString:@"markdownColumn"] )
    {
//        cellView.imageView.image = bugDoc.thumbImage;
        cellView.textField.stringValue = [self.markdownFileArray objectAtIndex:row];
        return cellView;
    }
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
    NSLog(@"%ld",[[notification object] selectedRow]);
}

#pragma mark - JZiCloudStorageManagerDelegate

- (void)iCloudFileUpdated:(NSMetadataQuery *)query
{

    if (!self.markdownFileArray)
    {
        self.markdownFileArray = [[NSMutableArray alloc] init];
    }
    [self.markdownFileArray removeAllObjects];
    
    for (NSMetadataItem *item in [query results])
    {
        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
        [self.markdownFileArray addObject:[url lastPathComponent]];
        NSLog(@"%@", [url path]);
    }
    [self.markdownListTableView reloadData];
}

@end
