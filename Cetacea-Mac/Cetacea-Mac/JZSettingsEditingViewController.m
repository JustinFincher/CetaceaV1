//
//  JZSettingsEditingViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/3.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZSettingsEditingViewController.h"
#import "JZFontDisplayManager.h"

@interface JZSettingsEditingViewController ()
@property (weak) IBOutlet NSTextField *fontPreviewTextField;
@property (strong,nonatomic) NSFont *selectedFont;
@end

@implementation JZSettingsEditingViewController
@synthesize selectedFont,fontPreviewTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    selectedFont = [[JZFontDisplayManager sharedManager] getFont];
    [self refreshPreviewTextField];
}

- (IBAction)fontPanelButtonClicked:(NSButton *)sender
{
    [[NSFontManager sharedFontManager] orderFrontFontPanel:self];
    [[NSFontManager sharedFontManager] setTarget:self];
    [[NSFontManager sharedFontManager] setAction:@selector(changeDefaultFont:)];
    [[NSFontManager sharedFontManager] setSelectedFont:selectedFont isMultiple:NO];
}

- (void)changeDefaultFont:(id)sender
{
    NSFont *oldFont = self.selectedFont;
    NSFont *newFont = [sender convertFont:oldFont];
    self.selectedFont = newFont;
    [self refreshPreviewTextField];
    [[JZFontDisplayManager sharedManager] setFont:selectedFont];
}

- (void)refreshPreviewTextField
{
    fontPreviewTextField.stringValue = [selectedFont fontName];
    fontPreviewTextField.font = selectedFont;
}

- (void)changedCustomFont:(id)sender
{
    //NSLog(@"New font: %@", [[NSFontManager sharedFontManager] selectedFont]);
}

- (CGSize)preferredMinimumSize
{
    return CGSizeMake(450, 150);
}

@end
