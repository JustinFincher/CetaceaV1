//
//  CSFiCloudSyncManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/1.
//
//

#import <Foundation/Foundation.h>


/**
 Delegates for iCloud updates
 */
@protocol CSFiCloudSyncDelegate <NSObject>
@optional

- (void)iCloudFileUpdated:(NSMutableArray *)list;

@end

@interface CSFiCloudSyncManager : NSObject


/**
 Singleton Method

 @return Instance
 */
+ (id)sharedManager;


/**
 Detect if iCloud Storage is enabled and logined

 @return BOOL value for iCloud Status
 */
- (BOOL)isIcloudAvailiable;


/**
 iCloud App Root URL
 @see [- (NSURL *)ubiquitousDocumentsURL](CSFiCloudSyncManager.html#/c:objc(cs)CSFiCloudSyncManager(im)ubiquitousDocumentsURL)
 @return NSURL
 */
- (NSURL *)ubiquitousURL;

/**
 URL For root/Documents/README

 @return NSURL
 */
- (NSURL *)ubiquitousDocumentsReadMeURL;

/**
 URL For root/Documents

 @return NSURL
 */
- (NSURL *)ubiquitousDocumentsURL;

/**
 URL For root/Documents/Cetacea
 
 @return NSURL
 */
- (NSURL *)ubiquitousDocumentsCetaceaURL;
/**
 URL For root/Documents/Theme
 
 @return NSURL
 */
- (NSURL *)ubiquitousDocumentsHighlightThemesURL;
- (void)directoryExistCheck:(NSURL *)url;
@property (nonatomic, strong) NSMetadataQuery *iCloudFilesMetadataQuery;
@property (nonatomic, strong) NSMetadataQuery *iCloudCetaceaFilesMetadataQuery;
@property (nonatomic, strong) NSMetadataQuery *iCloudThemeFilesMetadataQuery;

@property (nonatomic, assign) id <CSFiCloudSyncDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *cetaceaDocumentArray;
@property (nonatomic, strong) NSMutableArray *highlightThemesDocumentArray;
@end
