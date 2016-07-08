//
//  JZEditorHighlightThemeDataModel.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZColorDataModel.h"

@interface JZEditorHighlightThemeDataModel : NSObject<NSCoding>

- (id)initWithDefault;

@property (nonatomic,strong) NSString *themeName;
@property (nonatomic,strong) NSImage *previewJPG;

#pragma mark - View background color
@property (nonatomic,strong) JZColorDataModel *lightTextViewBackgroundColor;
@property (nonatomic,strong) JZColorDataModel *darkTextViewBackgroundColor;

@property (nonatomic,strong) JZColorDataModel *lightRulerViewBackgroundColor;
@property (nonatomic,strong) JZColorDataModel *darkRulerViewBackgroundColor;

#pragma mark - Text & tag Foreground color | Block background color

@property (nonatomic,strong) JZColorDataModel *lightRulerViewDefaultTextForegroundColor;
@property (nonatomic,strong) JZColorDataModel *darkRulerViewDefaultTextForegroundColor;
@property (nonatomic,strong) JZColorDataModel *lightRulerViewHighlightedTextForegroundColor;
@property (nonatomic,strong) JZColorDataModel *darkRulerViewHighlightedTextForegroundColor;

@property (nonatomic,strong) JZColorDataModel *lightBoldTextForegroundColor;
@property (nonatomic,strong) JZColorDataModel *darkBoldTextForegroundColor;
@property (nonatomic,strong) JZColorDataModel *lightBoldTagForegroundColor;
@property (nonatomic,strong) JZColorDataModel *darkBoldTagForegroundColor;

@property (nonatomic,strong) JZColorDataModel *lightItalicTextForegroundColor;
@property (nonatomic,strong) JZColorDataModel *darkItalicTextForegroundColor;
@property (nonatomic,strong) JZColorDataModel *lightItalicTagForegroundColor;
@property (nonatomic,strong) JZColorDataModel *darkItalicTagForegroundColor;


@end
