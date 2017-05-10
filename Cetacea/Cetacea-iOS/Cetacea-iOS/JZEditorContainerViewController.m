//
//  JZEditorContainerViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/10.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZEditorContainerViewController.h"

@interface JZEditorContainerViewController ()

@property (weak, nonatomic) IBOutlet UIView *editorContainerView;
@property (strong, nonatomic) UIViewPropertyAnimator *animator;

@end

@implementation JZEditorContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.editorContainerView.alpha = 0.0f;
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:0.1 curve:UIViewAnimationCurveEaseIn animations:^(void){}];
    
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(currentDocumentChanged:, CSF_String_Notification_Current_Document_Changed_Name, nil);
}

- (void)currentDocumentChanged:(NSNotification *)notif
{
    id doc = [[notif userInfo] objectForKey:@"doc"];
    BOOL isSelectionNull = [doc isKindOfClass:[NSNull class]];
    
    if (self.animator.isRunning)
    {
        [self.animator stopAnimation:YES];
    }
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:0.1 curve:UIViewAnimationCurveEaseIn animations:^(void)
                         {
                             self.editorContainerView.alpha = isSelectionNull ? 0.0f : 1.0f;
                         }];
    [self.animator startAnimation];
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
