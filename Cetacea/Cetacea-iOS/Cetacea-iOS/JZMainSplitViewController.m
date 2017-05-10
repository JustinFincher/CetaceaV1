//
//  JZMainSplitViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/4/30.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZMainSplitViewController.h"

@interface JZMainSplitViewController ()<UISplitViewControllerDelegate>

@end

@implementation JZMainSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.presentsWithGesture = NO;
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISplitViewControllerDelegate
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return YES;
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
