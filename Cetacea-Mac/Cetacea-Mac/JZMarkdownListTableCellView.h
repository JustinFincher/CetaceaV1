//
//  JZMarkdownListTableCellView.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZiCloudFileExtensionCetaceaDoc.h"

@interface JZMarkdownListTableCellView : NSTableCellView
@property (weak) IBOutlet NSTextField *contentTextField;
@property (weak) IBOutlet NSTextField *titleTextField;
@property (weak) JZiCloudFileExtensionCetaceaDoc *markdownDocReference;
@property (weak) IBOutlet NSTextField *updateDateTextField;
@property (weak) IBOutlet NSImageView *isStarredImageView;

@property (weak) NSTableView *tableView;


@end
