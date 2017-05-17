//
//  JZMainMarkdownListTableViewCell.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/9.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZMainMarkdownListTableViewCell.h"
#import "UIFontDescriptor+Avenir.h"

@interface JZMainMarkdownListTableViewCell()
@property (nonatomic,strong) UIViewPropertyAnimator *animator;
@end

@implementation JZMainMarkdownListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(contentSizeCategoryDidChange:, UIContentSizeCategoryDidChangeNotification, nil);
    
    [self applyStyles];
    
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:0.1 curve:UIViewAnimationCurveEaseIn animations:^(void)
                     {}];
}
- (void)setDoc:(CSFCetaceaAbstractSharedDocument *)doc
{
    _doc = doc;
    if (doc)
    {
        self.titleLabel.text = doc.title;
        self.contentTextView.text = doc.markdownString;
        self.lastChangeTimeLabel.text = doc.lastChangeDate.timeAgoSinceNow;
        
        if (doc.isDownloading)
        {
            self.syncIndicatorImageView.image = [UIImage imageNamed:@"icon_ios_download"];
        }else if (doc.isDownloading)
        {
            self.syncIndicatorImageView.image = [UIImage imageNamed:@"icon_ios_upload"];
        }else
        {
            self.syncIndicatorImageView.image = nil;
        }
    }else
    {
        self.titleLabel.text = @"Loading";
        self.contentTextView.text = @"Loading";
        self.lastChangeTimeLabel.text = @"";
    }
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (self.animator.isRunning)
    {
        [self.animator stopAnimation:YES];
    }
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:0.15f curve:UIViewAnimationCurveEaseIn animations:^(void)
                     {
                         if (selected)
                         {
                             self.contentView.backgroundColor = UIColorFromRGB(0x007AFF);
                             self.titleLabel.textColor = [UIColor whiteColor];
                             self.lastChangeTimeLabel.textColor = [UIColor whiteColor];
                             self.contentTextView.textColor = [UIColor whiteColor];
                             self.syncIndicatorImageView.tintColor = [UIColor whiteColor];
                         }else
                         {
                             self.contentView.backgroundColor = [UIColor clearColor];
                             self.titleLabel.textColor = [UIColor blackColor];
                             self.lastChangeTimeLabel.textColor = [UIColor lightGrayColor];
                             self.contentTextView.textColor = [UIColor darkGrayColor];
                             self.syncIndicatorImageView.tintColor = UIColorFromRGB(0x007AFF);
                         }
                     }];
    [self.animator startAnimation];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (self.animator.isRunning)
    {
        [self.animator stopAnimation:YES];
    }
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:0.15f curve:UIViewAnimationCurveEaseIn animations:^(void)
                     {
                         if (highlighted)
                         {
                             self.contentView.backgroundColor = UIColorFromRGB(0xD4E9FF);
                             self.titleLabel.textColor = [UIColor blackColor];
                             self.lastChangeTimeLabel.textColor = [UIColor lightGrayColor];
                             self.contentTextView.textColor = [UIColor darkGrayColor];
                             self.syncIndicatorImageView.tintColor = [UIColor whiteColor];
                         }else
                         {
                             self.contentView.backgroundColor = [UIColor clearColor];
                             self.titleLabel.textColor = [UIColor blackColor];
                             self.lastChangeTimeLabel.textColor = [UIColor lightGrayColor];
                             self.contentTextView.textColor = [UIColor darkGrayColor];
                             self.syncIndicatorImageView.tintColor = UIColorFromRGB(0x007AFF);
                         }
                     }];
    [self.animator startAnimation];

    
}

@end
