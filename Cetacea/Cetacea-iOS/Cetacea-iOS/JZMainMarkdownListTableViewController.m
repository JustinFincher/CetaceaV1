//
//  JZMainMarkdownListTableViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/8.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZMainMarkdownListTableViewController.h"
#import "JZMainMarkdownListTableViewCell.h"
#import <CetaceaSharedFramework/CSFGlobalHeader.h>
#import "JZSettingsNavigationController.h"
#import "JZEditorContainerViewController.h"

@interface JZMainMarkdownListTableViewController ()<CSFiCloudSyncDelegate,UISearchBarDelegate,UIPopoverPresentationControllerDelegate,UIViewControllerPreviewingDelegate,UISearchBarDelegate>

@property (nonatomic,strong) NSMutableArray *markdownArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *applicationSettingsButton;

@property (nonatomic,strong) id<UIViewControllerPreviewing> previewingContext;

@end

@implementation JZMainMarkdownListTableViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = YES;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JZMainMarkdownListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([JZMainMarkdownListTableViewCell class])];
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(contentSizeCategoryDidChange:, UIContentSizeCategoryDidChangeNotification, nil);
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(setCurrentEditingDocumentNull:, CSF_String_Notification_Set_Current_Editing_Document_Null_Name, nil);
    
    self.searchBar.delegate = self;
    [[CSFiCloudSyncManager sharedManager] setDelegate:self];
    
    if ([[CSFDeviceCapabilityManager sharedManager] isForceTouchAvailable])
    {
        self.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.tableView];
    }
//    self.feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
//    [self.feedbackGenerator prepare];

    self.searchBar.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIContentSize
- (CGFloat)rowHeightForUIContentSizeCategory:(NSString *)category
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @90.0,UIContentSizeCategoryExtraSmall,
                          @95.0,UIContentSizeCategorySmall,
                          @100.0,UIContentSizeCategoryMedium,
                          @110.0f,UIContentSizeCategoryLarge,
                          @115.0f,UIContentSizeCategoryExtraLarge,
                          @125.0f,UIContentSizeCategoryExtraExtraLarge,
                          @140.0f,UIContentSizeCategoryExtraExtraExtraLarge,
                          @140.0f,UIContentSizeCategoryAccessibilityMedium,
                          @150.0f,UIContentSizeCategoryAccessibilityLarge,
                          @160.0f,UIContentSizeCategoryAccessibilityExtraLarge,
                          @165.0f,UIContentSizeCategoryAccessibilityExtraExtraLarge,
                          @170.0f,UIContentSizeCategoryAccessibilityExtraExtraExtraLarge,
                          nil];
    return [dict[category] floatValue];
}
#pragma mark - Notificatons
- (void)setCurrentEditingDocumentNull:(NSNotification *)notif
{
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    [[CSFCetaceaSharedDocumentEditManager sharedManager] setCurrentEditingDocument:nil];
}
- (void)contentSizeCategoryDidChange:(NSNotification *)notif
{
    self.tableView.estimatedRowHeight = [self rowHeightForUIContentSizeCategory:[[UIApplication sharedApplication] preferredContentSizeCategory]];
    [self.tableView reloadData];
}
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
}
#pragma mark - CSFiCloudSyncDelegate
- (void)iCloudFileUpdated:(NSMutableArray *)list
{
    self.markdownArray = list;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    if ([self.markdownArray count]>0)
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections                = 1;
        self.tableView.backgroundView = nil;
        self.searchBar.hidden = NO;
    }
    else
    {
        UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
        noDataLabel.numberOfLines = 0;
        noDataLabel.text             = @"No markdown files.\n Press add to write.";
        noDataLabel.textColor        = [UIColor grayColor];
        noDataLabel.textAlignment    = NSTextAlignmentCenter;
        noDataLabel.font = [UIFont fontWithDescriptor:[UIFontDescriptor preferredAvenirBoldFontDescriptorWithTextStyle:UIFontTextStyleHeadline] size: 0];
        self.tableView.backgroundView = noDataLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.searchBar.hidden = YES;
    }
    return numOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.markdownArray)
    {
        return [self.markdownArray count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSFiCloudFileExtensionCetaceaSharedDocument *doc = [self.markdownArray objectAtIndex:indexPath.row];
    JZMainMarkdownListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JZMainMarkdownListTableViewCell class])];
    cell.doc = doc;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[CSFCetaceaSharedDocumentEditManager sharedManager] setCurrentEditingDocument:nil];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.markdownArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self rowHeightForUIContentSizeCategory:[[UIApplication sharedApplication] preferredContentSizeCategory]];
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSFiCloudFileExtensionCetaceaSharedDocument *doc = [self.markdownArray objectAtIndex:indexPath.row];
    if (doc)
    {

        [[[CSFFeedbackGeneratorManager sharedManager] selectionFeedbackGenerator] selectionChanged];
        [[CSFCetaceaSharedDocumentEditManager sharedManager] setCurrentEditingDocument:doc];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[CSFCetaceaSharedDocumentEditManager sharedManager] setCurrentEditingDocument:nil];
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma Button Events
- (IBAction)applicationSettingsButtonPressed:(UIBarButtonItem *)sender
{
    CGSize windowSize = [[[UIApplication sharedApplication] keyWindow] frame].size;
    JZSettingsNavigationController *naviVC = CSF_Block_Main_Storyboard_VC_From_Identifier(NSStringFromClass([JZSettingsNavigationController class]));
    naviVC.navigationBarHidden = NO;
    naviVC.modalPresentationStyle = UIModalPresentationPopover;
    naviVC.popoverPresentationController.delegate = self;
    naviVC.popoverPresentationController.barButtonItem = sender;
    naviVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    naviVC.preferredContentSize = CGSizeMake(windowSize.width > 360 ? 360 : windowSize.width, windowSize.height);
    [self presentViewController:naviVC animated:YES completion:nil];
    [[[CSFFeedbackGeneratorManager sharedManager] impactFeedbackGenerator] impactOccurred];
    
}
#pragma mark - UIAdaptivePresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}
#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSIndexPath *indexPath = [self.tableView
                              indexPathForRowAtPoint:location];
    JZMainMarkdownListTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell)
    {
        JZLog(@"cell = %@",cell);
        previewingContext.sourceRect = [self.tableView rectForRowAtIndexPath:indexPath];
        JZEditorContainerViewController *popVC =  CSF_Block_Main_Storyboard_VC_From_Class([JZEditorContainerViewController class]);
        popVC.preferredContentSize = CGSizeMake(320, 300);
        return popVC;
    }
    else
    {
            JZLog(@"cell = nil");
    }
    return nil;
}
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    JZLog(@"commitViewController");
}
#pragma mark - Force Touch
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    if ([[CSFDeviceCapabilityManager sharedManager] isForceTouchAvailable])
    {
        if (!self.previewingContext) {
            self.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.tableView];
        }
    } else
    {
        if (self.previewingContext) {
            [self unregisterForPreviewingWithContext:self.previewingContext];
            self.previewingContext = nil;
        }
    }
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [[[CSFFeedbackGeneratorManager sharedManager] selectionFeedbackGenerator] selectionChanged];
    return YES;
}
@end
