//
//  JZEditorSplitViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/10.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZEditorSplitViewController.h"
#import "JZNoticeEnableCloudServiceViewController.h"
#import "JZMainSplitViewController.h"

@interface JZEditorSplitViewController ()<UISplitViewControllerDelegate>

@property (nonatomic, strong) UIKeyCommand *switchEditorPanelPresentationKeyCommand;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editorLayoutSegmentControl;
@property (strong, nonatomic) UIViewPropertyAnimator *editorLayoutAnimator;


@property (nonatomic,strong) UIBarButtonItem *resizePanelButtonItem;
@end

@implementation JZEditorSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    self.preferredPrimaryColumnWidthFraction = 0.5f;
    self.minimumPrimaryColumnWidth = 0.0f;
    self.maximumPrimaryColumnWidth = CGFLOAT_MAX;
    
    self.resizePanelButtonItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(navigationItemResizeButtonPressed)];
    self.toolbarItems = [NSMutableArray arrayWithObject:self.resizePanelButtonItem];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    [self configureKeyCommands];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if (![[CSFiCloudSyncManager sharedManager] isIcloudAvailiable])
    {
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:CSF_Block_Main_Storyboard_VC_From_Identifier(NSStringFromClass([JZNoticeEnableCloudServiceViewController class]))];
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:navController animated:YES completion:nil];
    }
    BOOL isPrimaryPanelHidden = [(JZMainSplitViewController*)[[CSFSingletonRegister sharedManager] getRegisteredSingletonForClassName:NSStringFromClass([JZMainSplitViewController class])] isPrimayPanelHidden];
    [self.resizePanelButtonItem setImage:[UIImage imageNamed: (isPrimaryPanelHidden ? @"icon_ios_right" : @"icon_ios_left")]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation
- (IBAction)editorLayoutSegmentControlValueChanged:(UISegmentedControl *)sender
{
    [self editorLayoutSegmentControlValueChangedCallback:[sender selectedSegmentIndex]];
}
- (void)navigationItemResizeButtonPressed
{
    BOOL isPrimaryPanelHidden = [(JZMainSplitViewController*)[[CSFSingletonRegister sharedManager] getRegisteredSingletonForClassName:NSStringFromClass([JZMainSplitViewController class])] isPrimayPanelHidden];
    [self.resizePanelButtonItem setImage:[UIImage imageNamed: (!isPrimaryPanelHidden ? @"icon_ios_right" : @"icon_ios_left")]];
    CSF_Block_Post_Notification_With_Name_No_Object(CSF_String_Notification_Navigation_Resize_Item_Pressed_Name);
}
- (void)editorLayoutSegmentControlValueChangedCallback:(NSInteger)value
{
    CGFloat nextPreferredPrimaryColumnWidthFraction = 0.0f;
    switch (value) {
        case 0:
            nextPreferredPrimaryColumnWidthFraction = 0.0f;
            break;
        case 1:
            nextPreferredPrimaryColumnWidthFraction = 0.5f;
            break;
        case 2:
            nextPreferredPrimaryColumnWidthFraction = 1.0f;
            break;
    }
    if (self.editorLayoutAnimator == nil)
    {
        self.editorLayoutAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:0.3 curve:UIViewAnimationCurveEaseIn animations:^(void){}];
    }
    if (self.editorLayoutAnimator.isRunning)
    {
        [self.editorLayoutAnimator stopAnimation:YES];
    }
    self.editorLayoutAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:0.3 curve:UIViewAnimationCurveEaseIn animations:^(void)
    {
        self.preferredPrimaryColumnWidthFraction = nextPreferredPrimaryColumnWidthFraction;
    }];
    [self.editorLayoutAnimator startAnimation];
}

#pragma mark - UISplitViewControllerDelegate
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return YES;
}

#pragma mark - Key Command
- (void)configureKeyCommands
{
    self.switchEditorPanelPresentationKeyCommand = [UIKeyCommand keyCommandWithInput:@"N" modifierFlags:UIKeyModifierShift action:@selector(switchEditorPresentationPanel) discoverabilityTitle:@"Next Editor Layout"];
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (NSArray<UIKeyCommand *> *)keyCommands
{
    return @[self.switchEditorPanelPresentationKeyCommand];
}
- (void)switchEditorPresentationPanel
{
    [self.editorLayoutSegmentControl setSelectedSegmentIndex:(self.editorLayoutSegmentControl.selectedSegmentIndex >= 2 ? 0 : self.editorLayoutSegmentControl.selectedSegmentIndex + 1)];
    [self editorLayoutSegmentControlValueChangedCallback:self.editorLayoutSegmentControl.selectedSegmentIndex];
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
