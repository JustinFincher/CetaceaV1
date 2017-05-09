//
//  JZMainMarkdownListTableViewCell.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/9.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZMainMarkdownListTableViewCell.h"
#import "UIFontDescriptor+Avenir.h"

@implementation JZMainMarkdownListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(contentSizeCategoryDidChange:, UIContentSizeCategoryDidChangeNotification, nil);
    
    [self applyStyles];
}

- (void)contentSizeCategoryDidChange:(NSNotification *)notif
{
    [self applyStyles];
}
- (void)applyStyles
{
    self.titleLabel.font = [UIFont fontWithDescriptor:[UIFontDescriptor preferredAvenirBoldFontDescriptorWithTextStyle:UIFontTextStyleSubheadline] size: 0];
    self.contentTextView.font = [UIFont fontWithDescriptor:[UIFontDescriptor preferredAvenirFontDescriptorWithTextStyle:UIFontTextStyleCaption1] size: 0];
    self.lastChangeTimeLabel.font = [UIFont fontWithDescriptor:[UIFontDescriptor preferredAvenirFontDescriptorWithTextStyle:ARUIFontTextStyleCaption4] size: 0];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
