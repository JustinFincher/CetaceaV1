//
//  CSFiCloudSyncManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/1.
//
//

#import <Foundation/Foundation.h>

@interface CSFiCloudSyncManager : NSObject

+ (id)sharedManager;

- (BOOL)isIcloudAvailiable;

@property (nonatomic, strong) NSURL *iCloudUbiquitousURL;
@property (nonatomic, strong) NSMetadataQuery *iCloudCetaceaFilesMetadataQuery;
@property (nonatomic, strong) NSMetadataQuery *iCloudThemeFilesMetadataQuery;

@end
