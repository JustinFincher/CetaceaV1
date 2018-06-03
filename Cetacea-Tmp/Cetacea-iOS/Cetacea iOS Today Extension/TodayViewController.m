//
//  TodayViewController.m
//  Cetacea iOS Today Extension
//
//  Created by Justin Fincher on 2017/4/30.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UIButton *goHostApplicationButton;
@property (weak, nonatomic) IBOutlet UIView *embedView;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler
{
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}
#pragma mark - NCWidgetProviding
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode
                         withMaximumSize:(CGSize)maxSize
{
    if (activeDisplayMode == NCWidgetDisplayModeCompact)
    {
        self.preferredContentSize = maxSize;
    }
    else {
        self.preferredContentSize = CGSizeMake(0, 600.0);
    }
}
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsZero;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}
@end
