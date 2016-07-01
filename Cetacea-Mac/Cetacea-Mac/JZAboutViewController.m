//
//  JZAboutViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZAboutViewController.h"

@interface JZAboutViewController ()
@property (weak) IBOutlet NSTextField *cetaceaLabel;
@end

@implementation JZAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 4;
    shadow.shadowOffset = NSMakeSize(0, 0);
    shadow.shadowColor = [NSColor colorWithWhite:0.0f alpha:0.6f];
    _cetaceaLabel.shadow = shadow;
}


@end
