//
//  JZEditorContainerViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/10.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//
#import "JZEditorSplitViewController.h"
#import "JZEditorNavigationController.h"
#import "JZTraitCollectionManager.h"
@interface JZEditorContainerViewController ()

@property (weak, nonatomic) IBOutlet UIView *editorContainerView;
@property (strong, nonatomic) UIViewPropertyAnimator *animator;

@end

@implementation JZEditorContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.editorContainerView.alpha = 0.0f;
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:0.1 curve:UIViewAnimationCurveEaseIn animations:^(void){}];
    
    
    self.editorContainerView.alpha = [[CSFCetaceaSharedDocumentEditManager sharedManager] hasCurrentEditingDocument] ? 1.0f : 0.0f;
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(currentDocumentChanged:, CSFStringNotificationCurrentDocumentChangedName, nil);
}

- (void)currentDocumentChanged:(NSNotification *)notif
{
    BOOL hasSelection = [[CSFCetaceaSharedDocumentEditManager sharedManager] hasCurrentEditingDocument];
    
    if (self.animator.isRunning)
    {
        [self.animator stopAnimation:YES];
    }
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:0.1 curve:UIViewAnimationCurveEaseIn animations:^(void)
                     {
                         self.editorContainerView.alpha = hasSelection ? 1.0f : 0.0f;
                     }];
    [self.animator startAnimation];
}

- (BOOL)isEditorViewFaded
{
    return (self.editorContainerView.alpha == 0.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation
//- (void)leftEdgePanGestureProccess:(UIScreenEdgePanGestureRecognizer *)panGesture
//{
//    BOOL isHorizonalCompact = [JZTraitCollectionManager isHorizonalCompact];
//    if (isHorizonalCompact)
//    {
////        UIView *view = [self.view hitTest:[panGesture locationInView:self.view] withEvent:nil];
//        CGPoint t = [panGesture translationInView:self.view];
//        float progress = t.x / self.view.bounds.size.width;
//        
//        JZLog(@"panGesture Progress = %f",progress);
//        
//        if ([panGesture state] == UIGestureRecognizerStateBegan || [panGesture state] == UIGestureRecognizerStateChanged)
//        {
//            
//        }
//        else
//        {
//            
//        }
//    }
//
//}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditorContainerViewEmbedIdentifier"])
    {
        JZEditorNavigationController *vc = (JZEditorNavigationController *)[segue destinationViewController];
        self.editorNavigationController = vc;
    }
}


@end
