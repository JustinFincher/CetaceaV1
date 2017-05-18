//
//  CSFiCloudFileExtensionCetaceaDataBase.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import <Foundation/Foundation.h>
#import "CSFiCloudFileDataBase.h"


/**
 DataBase For iCloudFileExtensionCetacea (.cetacea) file.
 
 @see [CSFiCloudFileDataBase](CSFiCloudFileDataBase.html)

 ```
 - (NSString *)fileExtensionName
 {
 return @"cetacea";
 }
 - (NSString *)fileContainerFolderName
 {
 return @"Cetacea";
 }
 ```
 */
@interface CSFiCloudFileExtensionCetaceaDataBase : CSFiCloudFileDataBase

@end
