//
//  JZNoticeEnableCloudServiceViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/10.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZNoticeEnableCloudServiceViewController.h"

@interface JZNoticeEnableCloudServiceViewController ()

@end

@implementation JZNoticeEnableCloudServiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    CSF_Block_Add_Notification_Observer_With_Name_Object_Block(NSUbiquityIdentityDidChangeNotification,nil,^(NSNotification *notification)
                                                               {
                                                                   if ([[CSFiCloudSyncManager sharedManager] isIcloudAvailiable])
                                                                   {
                                                                       [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
                                                                   }
                                                               });

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
    if ([[CSFiCloudSyncManager sharedManager] isIcloudAvailiable])
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (IBAction)goToSettings:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=CASTLE"];
    if (url != nil && [[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url options:[NSDictionary new] completionHandler:nil];
    }
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
