//
//  JZMainListEditorSplitViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/30.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZMainListEditorSplitViewController.h"

@interface JZMainListEditorSplitViewController ()
@property (weak) IBOutlet NSSplitViewItem *listViewItem;
@property (weak) IBOutlet NSSplitViewItem *editorViewItem;
@end

@implementation JZMainListEditorSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    [_listViewItem setMaximumThickness:280];
    [_listViewItem setMinimumThickness:280];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sideBarButtonPressedNotification:)
                                                 name:@"sideBarButtonPressedNotification"
                                               object:nil];
}

- (void)sideBarButtonPressedNotification:(NSNotification *) notification
{
    NSDictionary *buttonStateDict = [notification userInfo];
    NSNumber *state = [buttonStateDict objectForKey:@"buttonState"];
    
    if ([state intValue] == 1 && _listViewItem.collapsed)
    {
        [self toggleSidebar:_listViewItem];
    }
    if ([state intValue] == 0 && !_listViewItem.collapsed)
    {
        [self toggleSidebar:_listViewItem];
    }
}

- (void)viewDidLayout
{

}

@end
