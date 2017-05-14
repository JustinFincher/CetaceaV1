//
//  JZSettingsTableViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/14.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import <Bohr/Bohr.h>
#import "BOTableViewSection+Footer.h"
#import "JZSettingsTableViewController.h"
#import <MessageUI/MessageUI.h>

@interface JZSettingsTableViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation JZSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [BOTableViewSection appearance].headerTitleColor = [UIColor colorWithWhite:0.5 alpha:1];
    [BOTableViewSection appearance].footerTitleColor = [UIColor colorWithWhite:0.6 alpha:1];
    
    [BOTableViewCell appearance].mainColor = [UIColor colorWithWhite:0.3 alpha:1];
    [BOTableViewCell appearance].secondaryColor = [UIColor colorWithRed:71/255.0 green:165/255.0 blue:254/255.0 alpha:1];
    [BOTableViewCell appearance].selectedColor = [UIColor colorWithRed:71/255.0 green:165/255.0 blue:254/255.0 alpha:1];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
                                                              @"com.JustZht.Cetacea.Settings.Appearance.Auto-Day-Night-Theme" : @YES,
                                                              @"com.JustZht.Cetacea.Settings.Appearance.Non-Auto-Day-Night-Theme.DayTime": [NSDate new],
                                                              @"com.JustZht.Cetacea.Settings.Appearance.Non-Auto-Day-Night-Theme.NightTime": [NSDate new]
                                                              }];
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup
{
    __unsafe_unretained typeof(self) weakSelf = self;
    
    NSString *versionBuildString = [NSString stringWithFormat:@"Version %@ (Build %@)",[[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"],[[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]];
    
    //    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"General" handler:^(BOTableViewSection *section)
    //                      {
    //                          [section addCell:[BOSwitchTableViewCell cellWithTitle:@"Switch 1" key:@"bool_1" handler:nil]];
    //                      }]];
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"Appearance" handler:^(BOTableViewSection *section)
                      {
                          [section addCell:[BOSwitchTableViewCell cellWithTitle:@"Auto Day / Night Theme" key:@"com.JustZht.Cetacea.Settings.Appearance.Auto-Day-Night-Theme" handler:nil]];
                          
                          [section addCell:[BOSwitchTableViewCell cellWithTitle:@"Switch 2" key:@"bool_2" handler:^(BOSwitchTableViewCell *cell) {
                              cell.visibilityKey = @"com.JustZht.Cetacea.Settings.Appearance.Auto-Day-Night-Theme";
                              cell.visibilityBlock = ^BOOL(id settingValue) {
                                  return [settingValue boolValue];
                              };
                              cell.onFooterTitle = @"Switch setting 2 is on";
                              cell.offFooterTitle = @"Switch setting 2 is off";
                          }]];
                          
                          [section addCell:[BOTimeTableViewCell cellWithTitle:@"Day Time" key:@"com.JustZht.Cetacea.Settings.Appearance.Non-Auto-Day-Night-Theme.DayTime" handler:^(BOTimeTableViewCell *cell)
                                            {
                                                cell.datePicker.minuteInterval = 10;
                                                cell.visibilityKey = @"com.JustZht.Cetacea.Settings.Appearance.Auto-Day-Night-Theme";
                                                cell.visibilityBlock = ^BOOL(id settingValue)
                                                {
                                                    return [settingValue boolValue];
                                                };
                                            }]];
                          [section addCell:[BOTimeTableViewCell cellWithTitle:@"Night Time" key:@"com.JustZht.Cetacea.Settings.Appearance.Non-Auto-Day-Night-Theme.NightTime" handler:^(BOTimeTableViewCell *cell)
                                            {
                                                cell.datePicker.minuteInterval = 10;
                                                cell.visibilityKey = @"com.JustZht.Cetacea.Settings.Appearance.Auto-Day-Night-Theme";
                                                cell.visibilityBlock = ^BOOL(id settingValue)
                                                {
                                                    return [settingValue boolValue];
                                                };
                                            }]];
                      }]];
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"Editor" handler:^(BOTableViewSection *section)
                      {
                          BONumberTableViewCell *fontSizeCell = [BONumberTableViewCell cellWithTitle:@"Font Size" key:@"com.JustZht.Cetacea.Settings.Editor.BaseFont.Size" handler:nil];
                          [section addCell:fontSizeCell];
                          BOChoiceTableViewCell *baseFontsCell = [BOChoiceTableViewCell cellWithTitle:@"Base Font" key:@"com.JustZht.Cetacea.Settings.Editor.BaseFont.Name" handler:^(BOChoiceTableViewCell *cell)
                                                                  {
                                                                  }];
                          baseFontsCell.options = [[CSFEditorTextFontManager sharedManager] getAllFontInApp];
                          
                          [section addCell:baseFontsCell];
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
