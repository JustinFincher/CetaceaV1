//
//  JZSettingsTabViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZSettingsTabViewController.h"

@interface JZSettingsTabViewController ()<NSTabViewDelegate>
@property (weak) IBOutlet NSTabView *noShadowTabVIew;
@property (weak) IBOutlet NSTabViewItem *generalTabViewItem;
@property (weak) IBOutlet NSTabViewItem *apperanceTabViewItem;

@end

@implementation JZSettingsTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.noShadowTabVIew.delegate = self;
}

- (void)viewWillAppear
{
    [self updateWindowSizeWithItem:_generalTabViewItem];
}

-(void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
    [super tabView:tabView willSelectTabViewItem:tabViewItem];
    [self updateWindowSizeWithItem:tabViewItem];
}
- (void)updateWindowSizeWithItem:(NSTabViewItem *)item
{
    NSWindow *window = self.view.window;
    NSSize contentSize = item.viewController.preferredMinimumSize;
    NSSize newWindowSize = [window frameRectForContentRect:(CGRect){CGPointZero, contentSize}].size;
    
    NSRect frame = [window frame];
    frame.origin.y += frame.size.height;
    frame.origin.y -= newWindowSize.height;
    frame.size = newWindowSize;
    
    [self.view.window setFrame:frame display:YES animate:YES];

}


@end