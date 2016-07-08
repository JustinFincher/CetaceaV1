//
//  JZiCloudFileExtensionCetaceaThemeDoc.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZEditorHighlightThemeDataModel.h"
#import "JZiCloudFileExtensionCetaceaThemeDataBase.h"

@interface JZiCloudFileExtensionCetaceaThemeDoc : NSObject

@property (nonatomic,strong) NSString * docPath;
@property (nonatomic,strong) JZEditorHighlightThemeDataModel *data;

- (instancetype)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;
- (JZEditorHighlightThemeDataModel *)getData;

- (NSImage *)getPreviewImage;

@end
