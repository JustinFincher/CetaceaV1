//
//  BOOptionTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 21/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOOptionTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@interface BOOptionTableViewCell()


@end

@implementation BOOptionTableViewCell

@synthesize settingsValue = _settingsValue;

- (void)setup {
	self.settingsValue = NSIntegerMin;
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

- (void)setSettingsValue:(NSInteger)settingsValue
{
	_settingsValue = settingsValue;
}

- (NSInteger)settingsValue
{
	return _settingsValue != NSIntegerMin ? _settingsValue : self.indexPath.row;;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController
{
    self.setting.value = @(self.settingsValue);
}

- (void)settingValueDidChange
{
    BOOL isSelected = ([self.setting.value integerValue] == self.settingsValue);
	self.accessoryType = isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
