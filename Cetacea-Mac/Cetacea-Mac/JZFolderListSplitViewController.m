//
//  JZFolderListSplitViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZFolderListSplitViewController.h"

@interface JZFolderListSplitViewController ()

@end

@implementation JZFolderListSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [_markdownListSplitViewItem setMaximumThickness:270];
    [_markdownListSplitViewItem setMinimumThickness:270];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sideBarSegmentSelectedNotification:)
                                                 name:@"sideBarSegmentSelectedNotification"
                                               object:nil];
}

- (void)sideBarSegmentSelectedNotification:(NSNotification *) notification
{
    NSDictionary *dict = [notification userInfo];
    NSNumber * selectNumber = (NSNumber *)[dict valueForKey:@"selectedSegment"];
    switch ([selectNumber integerValue])
    {
        case 2:
            break;
        case 1:
            if ([self isLeftFolderViewCollapsed])
            {
                //ALREADY COLLAPSED DO NOTHING
            }else
            {
                [self toggleSidebar:_folderSplitViewItem];
            }
            break;
        case 0:
            if ([self isLeftFolderViewCollapsed])
            {
                [self toggleSidebar:_folderSplitViewItem];
            }else
            {
                //ALREADY UNCOLLAPSED DO NOTHING
            }
            break;
            
        default:
            break;
    }
}

- (BOOL)isLeftFolderViewCollapsed
{
    return _folderSplitViewItem.collapsed;
}
@end
