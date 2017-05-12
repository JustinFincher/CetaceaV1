//
//  JZDocumentationWorkspaceBasePanelController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/12.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZDocumentationWorkspaceBasePanelController.h"
#import <PanelKit/PanelKit-umbrella.h>

@protocol PanelContentDelegate;

@interface JZDocumentationWorkspaceBasePanelController ()<PanelContentDelegate>

@end

@implementation JZDocumentationWorkspaceBasePanelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGSize)preferredPanelContentSize
{
    return CGSizeMake(400, 400);
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
