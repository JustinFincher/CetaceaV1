//
//  JZEditorHighlightThemeManager.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/14.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZiCloudFileExtensionCetaceaThemeDataBase.h"
#import "JZiCloudFileExtensionCetaceaThemeDoc.h"
@interface JZEditorHighlightThemeManager : NSObject

@property (nonatomic,strong) JZiCloudFileExtensionCetaceaThemeDoc *selectedDoc;

+ (id)sharedManager;


@end
