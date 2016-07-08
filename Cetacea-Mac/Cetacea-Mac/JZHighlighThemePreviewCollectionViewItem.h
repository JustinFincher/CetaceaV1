//
//  JZHighlighThemePreviewCollectionViewItem.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JZHighlighThemePreviewCollectionViewItem : NSCollectionViewItem
@property (weak) IBOutlet NSTextField *themeName;
@property (weak) IBOutlet NSImageView *themePic;
@property (nonatomic) BOOL isAddState;

@end
