//
//  JZSettingsTableViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/14.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "BOTableViewSection+Footer.h"
#import "JZSettingsTableViewController.h"
#import <MessageUI/MessageUI.h>

@interface JZSettingsTableViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation JZSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup
{
    NSString *versionBuildString = [NSString stringWithFormat:@"Version %@ (Build %@)",[[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"],[[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]];
    
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"General" handler:^(BOTableViewSection *section)
                      {
                          [section addCell:[BOSwitchTableViewCell cellWithTitle:@"Switch 1" key:@"bool_1" handler:nil]];
                      }]];
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"Appearance" handler:^(BOTableViewSection *section)
                      {
                          [section addCell:[BOSwitchTableViewCell cellWithTitle:@"Auto Day / Night Theme" key:@"com.JustZht.Cetacea.Settings.Appearance.Auto-Day-Night-Theme" handler:nil]];
                      }]];
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"About" FooterTitle:versionBuildString handler:^(BOTableViewSection *section)
                      {
                          if ([MFMailComposeViewController canSendMail])
                          {
                              BOButtonTableViewCell *sendSupportEmail = [BOButtonTableViewCell cellWithTitle:@"Email For Support" key:@"com.JustZht.Cetacea.Settings.About.Email-For-Support" handler:nil];
                              sendSupportEmail.actionBlock = ^(void)
                              {MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
                                  [composeViewController setMailComposeDelegate:self];
                                  [composeViewController setToRecipients:@[@"justzht+cetacea@gmail.com"]];
                                  [composeViewController setSubject:@"Cetacea iOS Request Support"];
                                  
                                  __weak UIViewController *vc = self.navigationController.presentingViewController;
                                  [vc dismissViewControllerAnimated:YES completion:^(void)
                                   {
                                       [vc presentViewController:composeViewController animated:YES completion:nil];
                                   }];
                              };
                              [section addCell:sendSupportEmail];
                          }
                          
                          BOButtonTableViewCell *visitAuthorPage = [BOButtonTableViewCell cellWithTitle:@"Visit Author Page" key:@"com.JustZht.Cetacea.Settings.About.Visit-Author-Page" handler:nil];
                          visitAuthorPage.actionBlock = ^(void){
                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://fincher.im"] options:[NSDictionary dictionary] completionHandler:nil];};
                          [section addCell:visitAuthorPage];
                          
                          [section addCell:[BOButtonTableViewCell cellWithTitle:@"Visit Cetacea Mac Alpha" key:@"com.JustZht.Cetacea.Settings.About.Visit-Cetacea-Mac" handler:^(id cell)
                                            {
                                                
                                            }]];
                      }]];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
