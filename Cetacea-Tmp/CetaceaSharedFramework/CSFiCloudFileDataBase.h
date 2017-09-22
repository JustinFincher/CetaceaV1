//
//  CSFiCloudFileDataBase.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>


/**
 DataBase Base Class for All iCloud Based Files.
 */
@interface CSFiCloudFileDataBase : NSObject

#pragma mark - Singleton
/**
 Singleton method

 @return database instance
 */
+ (id)sharedManager;

#pragma mark - File Path
/**
 returen [nextFileURL path];

 @return next file path
 */
- (NSString *)nextFilePath;

/**
 Return next file url for new document

 @return url for the next doc location
 */
- (NSURL *)nextFileURL;

#pragma mark - For Subclass

/**
 For Override
 @warning `fileExtensionName` must be overrided.
 @return file extension eg: cetacea for 'a.cetacea' file
 */
- (NSString *)fileExtensionName;

/**
 For Override
 @warning `fileContainerFolderName` must be overrided.
 @return folder name which the files will be saved
 */
- (NSString *)fileContainerFolderName;

/**
 For Override
 @warning `filesFromArray` must be overrided.
*/
- (NSMutableArray *)filesFromArray:(NSArray *)query;
@end
