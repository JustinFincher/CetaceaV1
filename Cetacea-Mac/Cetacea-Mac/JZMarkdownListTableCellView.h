//
//  JZMarkdownListTableCellView.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZiCloudFileExtensionCetaceaDocument.h"

@interface JZMarkdownListTableCellView : NSTableCellView
@property (weak) IBOutlet NSTextField *contentTextField;
@property (weak) IBOutlet NSTextField *titleTextField;
@property (weak) JZiCloudFileExtensionCetaceaDocument *markdownDocReference;
@property (weak) IBOutlet NSTextField *updateDateTextField;

@property (weak) NSTableView *tableView;


@end
