//
//  JZMainSplitViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/4/30.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZMainSplitViewController.h"
#import "JZEditorContainerViewController.h"
#import "JZEditorSplitViewController.h"
#import "JZMainNavigationController.h"

@interface JZMainSplitViewController ()<UISplitViewControllerDelegate>

@end

@implementation JZMainSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.presentsWithGesture = NO;
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    self.preferredPrimaryColumnWidthFraction = 0.3f;
    
    self.minimumPrimaryColumnWidth = 0.0f;
    self.maximumPrimaryColumnWidth = CGFLOAT_MAX;
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(currentDocumentChanged:, CSF_String_Notification_Current_Document_Changed_Name, nil);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self checkCurrentDocumentCallBackWithNextSizeCheck:NO NextSize:CGSizeZero];
}
#pragma mark - Notification
- (void)currentDocumentChanged:(NSNotification *)notif
{
    [self checkCurrentDocumentCallBackWithNextSizeCheck:NO NextSize:CGSizeZero];
}

- (void)checkCurrentDocumentCallBackWithNextSizeCheck:(BOOL)check
                                             NextSize:(CGSize)size
{
    if (!check)
    {
//        size = [[[UIApplication sharedApplication] keyWindow] frame].size;
        size = [self.view bounds].size;
    }
    BOOL hasSelection = [[CSFCetaceaSharedDocumentEditManager sharedManager] hasCurrentEditingDocument];
    BOOL isHorizonalCompact = size.width <= 568.0f;
    [UIView animateWithDuration:0.2 animations:^(void)
    {
        if (isHorizonalCompact)
        {
            self.preferredPrimaryColumnWidthFraction = hasSelection ? 0.0f : 1.0f;
        }else
        {
            self.preferredPrimaryColumnWidthFraction  = 0.3f;
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Size Class Override
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self checkCurrentDocumentCallBackWithNextSizeCheck:YES NextSize:size];
}

#pragma mark - UISplitViewControllerDelegate
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    BOOL isSelectionNull = ![[CSFCetaceaSharedDocumentEditManager sharedManager] hasCurrentEditingDocument];
    return YES;
}
- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController
{
    if ([primaryViewController isKindOfClass:[UINavigationController class]])
    {
        for (UIViewController *controller in [(UINavigationController *)primaryViewController viewControllers]) {
            if ([controller isKindOfClass:[JZEditorContainerViewController class]])
            {
                return controller;
            }
        }
    }
    
    JZEditorContainerViewController *containerVC = CSF_Block_Main_Storyboard_VC_From_Identifier(NSStringFromClass([JZEditorContainerViewController class]));
    return containerVC;
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

