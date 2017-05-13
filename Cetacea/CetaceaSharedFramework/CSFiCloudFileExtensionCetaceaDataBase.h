//
//  CSFiCloudFileExtensionCetaceaDataBase.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import <Foundation/Foundation.h>

@interface CSFiCloudFileExtensionCetaceaDataBase : NSObject

+ (id)sharedManager;

//- (NSMutableArray *)loadDocs;
- (NSMutableArray *)loadDocsFromQuery:(NSArray *)query;
- (NSString *)nextDocPath;
- (NSURL *)nextDocURL;


@end
