//
//  JZiCloudFileExtensionCetaceaDataBase.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/7.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZiCloudFileExtensionCetaceaDoc.h"
@interface JZiCloudFileExtensionCetaceaDataBase : NSObject


+ (id)sharedManager;


/**
 *  Get All JZiCloudFileExtensionCetaceaDocs
 *
 *  @return NSMutableArray of JZiCloudFileExtensionCetaceaDocs
 */
- (NSMutableArray *)loadDocs;

/**
 *  Get Next Available Doc Path
 *
 *  @return NSString
 */
- (NSString *)nextDocPath;

@end
