//
//  JZBaseContainerViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/10.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZBaseContainerViewController.h"

@interface JZBaseContainerViewController ()

@property (nonatomic, retain) UITraitCollection *overrideTraitCollection;

@end

@implementation JZBaseContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performTraitCollectionOverrideForSize:self.view.bounds.size];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self performTraitCollectionOverrideForSize:size];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)performTraitCollectionOverrideForSize:(CGSize)size
{
    _overrideTraitCollection = nil;
    
    if (size.width > 500.0)
    {
        _overrideTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
    }
    
    [self setOverrideTraitCollection:_overrideTraitCollection forChildViewController:self];
    
    for (UIViewController * view in self.childViewControllers)
    {
        [self setOverrideTraitCollection:_overrideTraitCollection forChildViewController:view];
    }
}

@end
