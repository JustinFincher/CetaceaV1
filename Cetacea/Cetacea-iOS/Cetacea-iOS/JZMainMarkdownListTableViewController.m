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

@interface JZMainMarkdownListTableViewController ()<CSFiCloudSyncDelegate,UISearchBarDelegate,UIPopoverPresentationControllerDelegate>

@property (nonatomic,strong) NSMutableArray *markdownArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *applicationSettingsButton;

@end

@implementation JZMainMarkdownListTableViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"JZMainMarkdownListTableViewCell" bundle:nil] forCellReuseIdentifier:@"JZMainMarkdownListTableViewCell"];
    [self.tableView setContentOffset:CGPointMake(0, self.searchBar.frame.size.height) animated:YES];
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(contentSizeCategoryDidChange:, UIContentSizeCategoryDidChangeNotification, nil);
    
    self.searchBar.delegate = self;
    [[CSFiCloudSyncManager sharedManager] setDelegate:self];
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
    JZMainMarkdownListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JZMainMarkdownListTableViewCell"];
    
    cell.titleLabel.text = doc.title;
    cell.contentTextView.text = doc.markdownString;
    cell.lastChangeTimeLabel.text = doc.lastChangeDate.timeAgoSinceNow;
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSFiCloudFileExtensionCetaceaSharedDocument *doc = [self.markdownArray objectAtIndex:indexPath.row];
    if (doc)
    {
        [[CSFCetaceaSharedDocumentEditManager sharedManager] setCurrentEditingDocument:doc];
    }
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma Button Events
- (IBAction)applicationSettingsButtonPressed:(UIBarButtonItem *)sender
{
    JZSettingsNavigationController *naviVC = CSF_Block_Main_Storyboard_VC_From_Identifier(NSStringFromClass([JZSettingsNavigationController class]));
    naviVC.navigationBarHidden = NO;
    naviVC.modalPresentationStyle = UIModalPresentationPopover;
    naviVC.popoverPresentationController.delegate = self;
    naviVC.popoverPresentationController.barButtonItem = sender;
    naviVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    naviVC.preferredContentSize = self.view.frame.size;
    [self presentViewController:naviVC animated:YES completion:nil];
}
#pragma mark - UIAdaptivePresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
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