//
//  BOFontSizeTableViewCell.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/14.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "BOFontSizeTableViewCell.h"

@implementation BOFontSizeTableViewCell

- (void)setup {

    self.stepperContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.frame.size.width / 3 < 165.0f ? 165.0f : self.frame.size.width / 3), 100.0f)];
    
    self.stepper = [[JZVerticalStepper alloc] initWithFrame:CGRectMake(8,8,self.stepperContainerView.bounds.size.width - 8,self.stepperContainerView.bounds.size.height - 16)];
    self.stepper.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.stepperContainerView addSubview:self.stepper];
    
    self.accessoryView = self.stepperContainerView;
    
    self.stepper.minValue = 5.0f;
    self.stepper.maxValue = 36.0f;
    self.stepper.stepValue = 0.5f;
    self.stepper.wraps = YES;
    self.stepper.textColor = [UIColor darkGrayColor];
    self.stepper.backgroundColor = [UIColor whiteColor];
    self.stepper.borderColor = [UIColor darkGrayColor];
    self.stepper.formatString = @"%0.1f pt";
    [self.stepper addTarget:self action:@selector(didChangeFontSize:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)settingValueDidChange {
//    self.detailTextLabel.text = [NSString stringWithFormat:@"%.0f pts",[self.setting.value floatValue]];
    self.stepper.value = [self.setting.value floatValue];
}

- (void)didChangeFontSize:(id)sender
{
    self.setting.value = [NSNumber numberWithFloat:self.stepper.value];
}


- (CGFloat)overrideHeight
{
    return 100.0f;
}


@end
