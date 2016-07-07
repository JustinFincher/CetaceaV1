//
//  JZiCloudFileExtensionCetaceaDoc.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/7.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "JZiCloudFileExtensionCetaceaDataModel.h"
#import "JZiCloudFileExtensionCetaceaDataBase.h"

@interface JZiCloudFileExtensionCetaceaDoc : NSObject

@property (nonatomic,strong) NSString * docPath;
@property (nonatomic,strong) JZiCloudFileExtensionCetaceaDataModel *data;

- (instancetype)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;
- (JZiCloudFileExtensionCetaceaDataModel *)getData;

- (NSImage *)loadImage:(NSString *)imageName;
- (void)saveImage:(NSImage *)image
         withName:(NSString *)imageName;



@end
