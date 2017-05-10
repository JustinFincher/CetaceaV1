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
    
    self.delegate = self;
    self.presentsWithGesture = NO;
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    self.preferredPrimaryColumnWidthFraction = 0.3f;
    
    self.minimumPrimaryColumnWidth = 0.0f;
    self.maximumPrimaryColumnWidth = CGFLOAT_MAX;
    
    __weak typeof(self) weakSelf = self;
    CSF_Block_Add_Notification_Observer_With_Name_Object_Block(CSF_String_Notification_Current_Document_Changed_Name, nil, ^(NSNotification *notif)
                                                               {
                                                                   
                                                               });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Size Class Override
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
//    for (UIViewController *vc in self.childViewControllers) {
//        [self setOverrideTraitCollection:[self traitCollection] forChildViewController:vc];
//    }
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
}
//- (UITraitCollection *)traitCollection
//{
//    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone && UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]))
//    {
//        return [UITraitCollection traitCollectionWithTraitsFromCollections:[NSArray arrayWithObjects:[UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular],[UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact], nil]];
//    }
//    return [super traitCollection];
//}
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

