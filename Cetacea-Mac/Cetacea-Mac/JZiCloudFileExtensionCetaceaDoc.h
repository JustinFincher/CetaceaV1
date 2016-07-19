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

/**
 *  Get new doc from path. if path already there, return original doc.
 *
 *  @param docPath NSString
 *
 *  @return JZiCloudFileExtensionCetaceaDoc
 */
- (instancetype)initWithDocPath:(NSString *)docPath;

/**
 *  Save Doc
 */
- (void)saveData;

/**
 *  Delete Doc
 */
- (void)deleteDoc;

/**
 *  Get Doc Data.
 *
 *  @return JZiCloudFileExtensionCetaceaDataModel
 */
- (JZiCloudFileExtensionCetaceaDataModel *)getData;

- (NSImage *)loadImage:(NSString *)imageName;
- (void)saveImage:(NSImage *)image
         withName:(NSString *)imageName;



@end
