//
//  JZMarkdownListViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/30.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZMarkdownListViewController.h"

@interface JZMarkdownListViewController ()<NSTableViewDelegate,NSTableViewDataSource>
@property (weak) IBOutlet NSTableView *markdownListTableView;

@end

@implementation JZMarkdownListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.markdownListTableView.delegate = self;
    self.markdownListTableView.dataSource = self;
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if( [tableColumn.identifier isEqualToString:@"markdownColumn"] )
    {
//        cellView.imageView.image = bugDoc.thumbImage;
        //cellView.textField.stringValue = @"";
        return cellView;
    }
    return cellView;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 10;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 96;
}

@end
