//
//  JZEditorHighlightThemeDataModel.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZEditorHighlightThemeSingleRowDataModel.h"

@interface JZEditorHighlightThemeDataModel : NSObject<NSCoding>

- (id)initWithDefault;

@property (nonatomic,strong) NSString *themeName;
@property (nonatomic,strong) NSImage *previewJPG;

#pragma mark - Text & tag Foreground color | Block background color
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

- (void)getAttributes;
@end
