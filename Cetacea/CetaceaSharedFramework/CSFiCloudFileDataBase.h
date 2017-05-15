//
//  CSFiCloudFileDataBase.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>

@interface CSFiCloudFileDataBase : NSObject

+ (id)sharedManager;

- (NSString *)nextFilePath;
- (NSURL *)nextFileURL;

#pragma mark - For Subclass
- (NSString *)fileExtensionName;
- (NSString *)fileContainerFolderName;
- (NSMutableArray *)filesFromArray:(NSArray *)query;
@end
