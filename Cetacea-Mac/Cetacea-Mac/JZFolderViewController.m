//
//  JZFolderViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZFolderViewController.h"
#import "JZiCloudFileSystemItem.h"
#import "JZFolderOutlineCellView.h"

@interface JZFolderViewController ()<NSOutlineViewDataSource,NSOutlineViewDelegate>
@property (weak) IBOutlet NSOutlineView *outlineView;

@end

@implementation JZFolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.outlineView.delegate = self;
    self.outlineView.dataSource = self;
}
- (void)viewDidAppear
{
    [[JZiCloudFileSystemItem rootItem] refresh];
    [self.outlineView reloadData];
    //[self.outlineView expandItem:[JZiCloudFileSystemItem rootItem] expandChildren:YES];
}

#pragma mark - NSOutlineViewDataSource
- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(id)item
{
    return (item == nil) ? 1 : [item numberOfChildrenFolder];
}
- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(id)item
{
    return (item == nil) ? YES : ([item numberOfChildrenFolder] != 0);
}
- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)item
{
    return (item == nil) ? [JZiCloudFileSystemItem rootItem] : [(JZiCloudFileSystemItem *)item childFolderAtIndex:index];
}
- (id)outlineView:(NSOutlineView *)outlineView
objectValueForTableColumn:(NSTableColumn *)tableColumn
           byItem:(id)item
{
    return (item == nil) ? @"/" : [item relativePath];
}
#pragma mark - NSOutlineViewDelegate

- (NSView *)outlineView:(NSOutlineView *)outlineView
     viewForTableColumn:(NSTableColumn *)tableColumn
                   item:(id)item
{
    if (NO)
    {
//        NSTableCellView *view = [self.outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
//        view.textField.stringValue = [[item relativePath] uppercaseString];
//        return view;
    }else
    {
        JZFolderOutlineCellView *view = [self.outlineView makeViewWithIdentifier:@"DataCell" owner:self];
        view.textField.stringValue = [item relativePath];
        view.childCountButton.title = [NSString stringWithFormat:@"%ld",(long)[item numberOfChildrenMD]];
        return view;
    }
    
}
- (CGFloat)outlineView:(NSOutlineView *)outlineView
     heightOfRowByItem:(id)item
{
    return 30.0f;
}

@end
