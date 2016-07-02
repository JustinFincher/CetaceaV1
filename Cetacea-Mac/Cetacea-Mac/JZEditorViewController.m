//
//  JZEditorViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorViewController.h"
#import "JZEditorMarkdownTextStorage.h"

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
    
}

#pragma mark - NSTextViewDelegate
-(void)textDidChange:(NSNotification *)notification
{
    //NSDictionary *userInfo = [NSDictionary dictionaryWithObject:myObject forKey:@"someKey"];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"markdownEditorTextDidChanged" object:nil userInfo:nil];
}

@end
