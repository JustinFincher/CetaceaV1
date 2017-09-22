//
//  JZEditorHighlightThemeSingleRowDataModel.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/9.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZEditorHighlightThemeColorDataModel.h"
@class JZEditorHighlightThemeDataModel;

@interface JZEditorHighlightThemeSingleRowDataModel : NSObject<NSCoding>

@property (nonatomic,strong) JZEditorHighlightThemeColorDataModel *lightForegroundTextColor;
@property (nonatomic,strong) JZEditorHighlightThemeColorDataModel *lightForegroundTagtColor;
@property (nonatomic,strong) JZEditorHighlightThemeColorDataModel *lightBackgroundBlockColor;

@property (nonatomic,strong) JZEditorHighlightThemeColorDataModel *darkForegroundTextColor;
@property (nonatomic,strong) JZEditorHighlightThemeColorDataModel *darkForegroundTagtColor;
@property (nonatomic,strong) JZEditorHighlightThemeColorDataModel *darkBackgroundBlockColor;

/**
 *  Default Style
 *
 *  @return JZEditorHighlightThemeSingleRowDataModel Instance
 */
- (id)initWithDefaultTextStyle;

@end
