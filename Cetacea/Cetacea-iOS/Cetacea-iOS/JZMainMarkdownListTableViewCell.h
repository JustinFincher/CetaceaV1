//
//  JZMainMarkdownListTableViewCell.h
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/9.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMainMarkdownListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *syncIndicatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastChangeTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) CSFiCloudFileExtensionCetaceaSharedDocument *doc;

@end
