//
//  CSFiCloudSyncManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/1.
//
//

#import <Foundation/Foundation.h>

@protocol CSFiCloudSyncDelegate <NSObject>
@optional

/**
 *  iCloud Drive Query updated delegate
 *
 *  @param query give you a query of searched NSMetadataItems
 */
- (void)iCloudFileUpdated:(NSMetadataQuery *)query;

@end

@interface CSFiCloudSyncManager : NSObject

+ (id)sharedManager;

- (BOOL)isIcloudAvailiable;

- (NSURL *)ubiquitousURL;
- (NSURL *)ubiquitousDocumentsURL;
- (NSURL *)ubiquitousDocumentsCetaceaURL;
- (NSURL *)ubiquitousDocumentsHighlightThemesURL;
@property (nonatomic, strong) NSMetadataQuery *iCloudFilesMetadataQuery;
@property (nonatomic, strong) NSMetadataQuery *iCloudCetaceaFilesMetadataQuery;
@property (nonatomic, strong) NSMetadataQuery *iCloudThemeFilesMetadataQuery;

@property (nonatomic, assign) id <CSFiCloudSyncDelegate> delegate;
@end
