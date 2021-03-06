//
//  JZDocumentWorkspaceSplitEditorViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/13.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZDocumentWorkspaceSplitEditorViewController.h"
#import <CetaceaSharedFramework/CetaceaSharedFramework.h>
@interface JZDocumentWorkspaceSplitEditorViewController ()

@property (weak, nonatomic) IBOutlet CSFEditorTextView *textView;

@end

@implementation JZDocumentWorkspaceSplitEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(currentDocumentChanged:, CSFStringNotificationCurrentDocumentChangedName, nil);
}
- (void)currentDocumentChanged:(NSNotification *)notif
{
    BOOL isSelectionNull = ![[CSFCetaceaSharedDocumentEditManager sharedManager] hasCurrentEditingDocument];
    if (!isSelectionNull)
    {
        CSFCetaceaAbstractSharedDocument *sharedDoc = [[notif userInfo] objectForKey:@"doc"];
        [self.textView setCurrentEditingDocument:sharedDoc];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
