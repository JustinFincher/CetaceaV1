//
//  JZMarkdownListTableCellView.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZiCloudMarkdownFileModel.h"

@interface JZMarkdownListTableCellView : NSTableCellView
@property (weak) IBOutlet NSTextField *contentTextField;
@property (weak) IBOutlet NSTextField *titleTextField;
@property (weak) JZiCloudMarkdownFileModel *markdownReference;

@end
