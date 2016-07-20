//
//  JZEditorHighlightThemeSingleRowDataModel.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/9.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZColorDataModel.h"

@interface JZEditorHighlightThemeSingleRowDataModel : NSObject<NSCoding>

@property (nonatomic,strong) JZColorDataModel *lightForegroundTextColor;
@property (nonatomic,strong) JZColorDataModel *lightForegroundTagtColor;
@property (nonatomic,strong) JZColorDataModel *lightBackgroundBlockColor;

@property (nonatomic,strong) JZColorDataModel *darkForegroundTextColor;
@property (nonatomic,strong) JZColorDataModel *darkForegroundTagtColor;
@property (nonatomic,strong) JZColorDataModel *darkBackgroundBlockColor;

/**
 *  Default Style
 *
 *  @return JZEditorHighlightThemeSingleRowDataModel Instance
 */
- (id)initWithDefaultTextStyle;

@end
