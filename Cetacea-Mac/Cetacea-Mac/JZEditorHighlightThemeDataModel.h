//
//  JZEditorHighlightThemeDataModel.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZEditorHighlightThemeSingleRowDataModel.h"
#import "JZFontDisplayManager.h"

@interface JZEditorHighlightThemeDataModel : NSObject<NSCoding>

- (id)initWithDefault;

@property (nonatomic,strong) NSString *themeName;
@property (nonatomic,strong) NSImage *previewJPG;


#pragma mark - Text & tag Foreground color | Block background color
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *DefaultDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *AtxHeaderDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *SetextHeaderDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *CodeBlockDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *TabIndentDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *BoldDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *ItalicDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *StrikeThroughDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *ListDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *QuoteDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *ImageDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *LinkDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *EditorViewDataModel;
@property (nonatomic,strong) JZEditorHighlightThemeSingleRowDataModel *RuleViewDataModel;

@property (nonatomic,strong)NSDictionary<NSString *, id> *DefaultTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *AtxHeaderTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *AtxHeaderTagAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *SetextHeaderTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *SetextHeaderTagAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *CodeBlockTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *CodeBlockTagAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *TabIndentTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *TabIndentTagAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *BoldTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *BoldTagAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *ItalicTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *ItalicTagAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *ListTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *ListTagAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *QuoteTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *QuoteTagAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *ImageTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *ImageTagAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *LinkTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *LinkTagAttributes;

- (void)getAttributes;
- (NSColor *)getBackgroundColor;
@end
