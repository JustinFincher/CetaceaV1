//
//  MKColorWell.h
//  Color Picker
//
//  Created by Mark Dodwell on 5/26/12.
//  Copyright (c) 2012 mkdynamic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZEditorHighlightThemeColorDataModel.h"
#import "KeyValueObserver.h"
#import "JZiCloudFileExtensionCetaceaThemeDoc.h"

@interface MKColorWell : NSColorWell {
    NSPopover *popover;
    NSViewController *popoverViewController;
    NSView *popoverView;
}

@property (nonatomic, assign) BOOL animatePopover;

@property (nonatomic, strong) NSString *colorWellDescrption;

- (void)setColorAndClose:(NSColor *)aColor;

@property (nonatomic, strong) NSString *labelString;

@property (nonatomic, strong) JZEditorHighlightThemeColorDataModel *colorData;

@end
