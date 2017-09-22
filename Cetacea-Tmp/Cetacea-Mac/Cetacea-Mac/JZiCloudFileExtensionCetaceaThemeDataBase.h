//
//  JZiCloudFileExtensionCetaceaThemeDataBase.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZiCloudFileExtensionCetaceaThemeDoc.h"

@interface JZiCloudFileExtensionCetaceaThemeDataBase : NSObject

+ (id)sharedManager;

- (NSMutableArray *)loadDocs;
- (NSString *)nextDocPath;

@end
