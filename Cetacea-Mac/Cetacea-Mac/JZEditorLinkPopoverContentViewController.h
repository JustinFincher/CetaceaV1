//
//  JZEditorLinkPopoverContentViewController.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/4.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JZEditorLinkPopoverContentViewController : NSViewController

- (void)proccessURL:(NSURL *)url;
@property(weak)NSPopover *parentPopover;
@end
