//
//  JZEditorViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorViewController.h"
#import "JZEditorMarkdownTextStorage.h"
#import "JZFontDisplayManager.h"

@interface JZEditorViewController ()<NSTextViewDelegate>

@property (nonatomic,strong) JZEditorMarkdownTextStorage *textStorage;

@end

@implementation JZEditorViewController
@synthesize editorTextView,editorScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.editorTextView.delegate = self;
    self.textStorage = [JZEditorMarkdownTextStorage new];
    [self.textStorage addLayoutManager:self.editorTextView.layoutManager];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(baseFontChanged:)
                                                 name:@"baseFontChanged"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dayNightThemeSwitched:)
                                                 name:@"dayNightThemeSwitched"
                                               object:nil];
    [self refreshFont];
}

- (void)setCurrentEditingMarkdown:(JZiCloudMarkdownFileModel *)currentEditingMarkdown
{
    NSError *error;
    self.editorTextView.string = [NSString stringWithContentsOfFile:[currentEditingMarkdown.url path] encoding:NSUTF8StringEncoding error:&error];
    if (error)
    {
        NSLog(@"%@",[error localizedDescription]);
    }
    [self.textStorage updateAllFileHighLight];
    
}
- (void)dayNightThemeSwitched:(NSNotification *)aNotification
{
    [self.textStorage updateAllFileHighLight];
}
- (void)baseFontChanged:(NSNotification *)aNotification
{
    [self refreshFont];
}
- (void)refreshFont
{
    NSFont *font = [[JZFontDisplayManager sharedManager] getFont];
    self.editorTextView.font = font;
}

#pragma mark - NSTextViewDelegate
/**
 *  this delegate called when TextView 's text have delete or input
 *
 *  @param notification NSNotification
 */
-(void)textDidChange:(NSNotification *)notification
{
    //NSDictionary *userInfo = [NSDictionary dictionaryWithObject:myObject forKey:@"someKey"];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"markdownEditorTextDidChanged" object:nil userInfo:nil];
    
    [self refreshFont];
}

@end
