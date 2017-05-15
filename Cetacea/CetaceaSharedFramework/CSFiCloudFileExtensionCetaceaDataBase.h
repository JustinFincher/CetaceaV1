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

- (NSMutableArray *)loadDocsFromArray:(NSArray *)query;
- (NSDictionary *)loadDocsFromQuery:(NSMetadataQuery *)query
                              added:(NSArray *)added
                            changed:(NSArray *)changed
                            removed:(NSArray *)removed;
- (NSString *)nextDocPath;
- (NSURL *)nextDocURL;


@end
