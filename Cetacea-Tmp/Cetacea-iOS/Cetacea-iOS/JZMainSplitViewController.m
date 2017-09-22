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
#import "JZTraitCollectionManager.h"

@interface JZMainSplitViewController ()<UISplitViewControllerDelegate>

@end

@implementation JZMainSplitViewController
- (void)dealloc
{
    [[CSFSingletonRegister sharedManager] unRegisterSingleton:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CSFSingletonRegister sharedManager] registerSingleton:self];
    
    self.delegate = self;
    self.presentsWithGesture = NO;
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    self.preferredPrimaryColumnWidthFraction = 0.3f;
    
    self.minimumPrimaryColumnWidth = 0.0f;
    self.maximumPrimaryColumnWidth = CGFLOAT_MAX;
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(currentDocumentChanged:, CSFStringNotificationCurrentDocumentChangedName, nil);
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(navigationItemResizeButtonPressed:, CSF_String_Notification_Navigation_Resize_Item_Pressed_Name, nil);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setCurrentDocumentWithSplitViewNextSizeCheck:NO NextSize:CGSizeZero];
}
- (BOOL)isPrimayPanelHidden
{
    return self.preferredPrimaryColumnWidthFraction == 0.0f;
}
#pragma mark - Notification
- (void)currentDocumentChanged:(NSNotification *)notif
{
    BOOL isSelectionNull = ![[CSFCetaceaSharedDocumentEditManager sharedManager] hasCurrentEditingDocument];
    if (!isSelectionNull)
    {
        [self setCurrentDocumentWithSplitViewNextSizeCheck:NO NextSize:CGSizeZero];
    }
}
- (void)navigationItemResizeButtonPressed:(NSNotification *)notif
{
    BOOL isHorizonalCompact = [JZTraitCollectionManager isHorizonalCompact];
    if (self.preferredPrimaryColumnWidthFraction == 0.0f && isHorizonalCompact)
    {
        CSF_Block_Post_Notification_With_Name_Object(CSF_String_Notification_Set_Current_Editing_Document_Null_Name, nil);
    }
    [UIView animateWithDuration:0.2 animations:^(void)
     {
         if (isHorizonalCompact)
         {
             self.preferredPrimaryColumnWidthFraction =  (self.preferredPrimaryColumnWidthFraction == 1.0f) ? 0.0f : 1.0f;
         }else
         {
             self.preferredPrimaryColumnWidthFraction =  (self.preferredPrimaryColumnWidthFraction == 0.3f) ? 0.0f : 0.3f;
         }
     } completion:^(BOOL finished)
     {
         
     }];
    
}
- (void)setCurrentDocumentWithSplitViewNextSizeCheck:(BOOL)check
                                             NextSize:(CGSize)size
{
    if (!check)
    {
        size = [[[[UIApplication sharedApplication] windows] firstObject] bounds].size;
    }
    BOOL hasSelection = [[CSFCetaceaSharedDocumentEditManager sharedManager] hasCurrentEditingDocument];
    BOOL isHorizonalCompact = [JZTraitCollectionManager horizonalTraitCollectionWithValue:size.width] == JZTraitCollectionLayoutStyleCompact;
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
    [self setCurrentDocumentWithSplitViewNextSizeCheck:YES NextSize:size];
}

#pragma mark - UISplitViewControllerDelegate
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
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

