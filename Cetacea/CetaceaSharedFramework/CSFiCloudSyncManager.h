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

- (void)iCloudFileUpdated:(NSMutableArray *)list;

@end

@interface CSFiCloudSyncManager : NSObject

+ (id)sharedManager;

- (BOOL)isIcloudAvailiable;

- (NSURL *)ubiquitousURL;
- (NSURL *)ubiquitousDocumentsReadMeURL;
- (NSURL *)ubiquitousDocumentsURL;
- (NSURL *)ubiquitousDocumentsCetaceaURL;
- (NSURL *)ubiquitousDocumentsHighlightThemesURL;
- (void)directoryExistCheck:(NSURL *)url;
@property (nonatomic, strong) NSMetadataQuery *iCloudFilesMetadataQuery;
@property (nonatomic, strong) NSMetadataQuery *iCloudCetaceaFilesMetadataQuery;
@property (nonatomic, strong) NSMetadataQuery *iCloudThemeFilesMetadataQuery;

@property (nonatomic, assign) id <CSFiCloudSyncDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *cetaceaDocumentArray;
@property (nonatomic, strong) NSMutableArray *highlightThemesDocumentArray;
@end
