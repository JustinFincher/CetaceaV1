//
//  JZHighlighThemePreviewCollectionViewItem.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZEditorTextView.h"
#import "JZiCloudFileExtensionCetaceaThemeDoc.h"

@interface JZHighlighThemePreviewCollectionViewItem : NSCollectionViewItem
@property (weak) IBOutlet NSTextField *themeName;
@property (weak) IBOutlet NSScrollView *themePreviewScrollView;
@property (unsafe_unretained) IBOutlet JZEditorTextView *themePreviewTextView;

@property (nonatomic,strong) NSColor *shadowColor;
- (void)initWithTheme:(JZiCloudFileExtensionCetaceaThemeDoc *)doc
            themeName:(NSString *)string;
@end
