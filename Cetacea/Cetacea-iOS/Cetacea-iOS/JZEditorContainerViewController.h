//
//  JZEditorContainerViewController.h
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/10.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZEditorContainerViewController : UIViewController

- (BOOL)isEditorViewFaded;
@property (nonatomic,strong) UINavigationController *editorNavigationController;

@end