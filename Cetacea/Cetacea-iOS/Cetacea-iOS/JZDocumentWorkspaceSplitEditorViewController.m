//
//  JZDocumentWorkspaceSplitEditorViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/13.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZDocumentWorkspaceSplitEditorViewController.h"

@interface JZDocumentWorkspaceSplitEditorViewController ()

@property (weak, nonatomic) IBOutlet CSFEditorTextView *textView;

@end

@implementation JZDocumentWorkspaceSplitEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(currentDocumentChanged:, CSF_String_Notification_Current_Document_Changed_Name, nil);
}
- (void)currentDocumentChanged:(NSNotification *)notif
{
    
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
