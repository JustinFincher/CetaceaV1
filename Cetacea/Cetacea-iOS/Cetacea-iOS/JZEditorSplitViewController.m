//
//  JZEditorSplitViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/10.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZEditorSplitViewController.h"

@interface JZEditorSplitViewController ()

@end

@implementation JZEditorSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    self.preferredPrimaryColumnWidthFraction = 0.5f;

    self.navigationItem.leftBarButtonItem = self.navigationController.splitViewController.displayModeButtonItem;
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
