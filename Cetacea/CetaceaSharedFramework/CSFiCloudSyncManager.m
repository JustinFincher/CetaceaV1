//
//  CSFiCloudSyncManager.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/1.
//
//

#import "CSFiCloudSyncManager.h"
#import "CSFGlobalHeader.h"

@interface CSFiCloudSyncManager()
@property (nonatomic, strong) NSURL *iCloudUbiquitousURL;
@end

@implementation CSFiCloudSyncManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static CSFiCloudSyncManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ubiquityIdentityDidChanged:)
                                                     name:NSUbiquityIdentityDidChangeNotification
                                                   object:nil];
        
        if ([self isIcloudAvailiable])
        {
            JZLog(@"isIcloudAvailiable = YES");
            [[NSUbiquitousKeyValueStore defaultStore] synchronize];
            
            NSOperationQueue *quene = [[NSOperationQueue alloc] init];
            [quene addOperationWithBlock:^{
                self.iCloudUbiquitousURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^
                 {
                     JZLog(@"ubiquitousURL = %@",[self ubiquitousURL]);
                     JZLog(@"ubiquitousDocumentsCetaceaURL = %@",[self ubiquitousDocumentsCetaceaURL]);
                     
                     self.iCloudCetaceaFilesMetadataQuery = [[NSMetadataQuery alloc] init];
                     self.iCloudCetaceaFilesMetadataQuery.notificationBatchingInterval = 1.0;
                     [self.iCloudCetaceaFilesMetadataQuery setSearchScopes:[NSArray arrayWithObjects: [self ubiquitousDocumentsCetaceaURL], NSMetadataQueryUbiquitousDocumentsScope, nil]];
                     [self.iCloudCetaceaFilesMetadataQuery setPredicate:[NSPredicate predicateWithFormat:@"%K like '*.cetacea'", NSMetadataItemFSNameKey]];
                     
                     CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(didStartGatheriCloudFiles:,NSMetadataQueryDidStartGatheringNotification,self.iCloudCetaceaFilesMetadataQuery)
                     CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(didGatheringiCloudFiles:,NSMetadataQueryGatheringProgressNotification,self.iCloudCetaceaFilesMetadataQuery)
                     CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(didUpdateiCloudFiles:,NSMetadataQueryDidFinishGatheringNotification,self.iCloudCetaceaFilesMetadataQuery)
                     CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(didUpdateiCloudFiles:,NSMetadataQueryDidUpdateNotification,self.iCloudCetaceaFilesMetadataQuery)
                     
                     if([self.iCloudCetaceaFilesMetadataQuery startQuery])
                     {
                         JZLog(@"iCloudCetaceaFilesMetadataQuery startQuery Successful");
                     };
                 }];
            }];
        }else
        {
            JZLog(@"isIcloudAvailiable = NO");
            CSF_Block_Post_Notification_With_No_Object(CSF_String_Notification_iCloud_Not_Availiable_Name)
        }
    }
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - Propoties

- (NSURL *)ubiquitousURL
{
    return self.iCloudUbiquitousURL;
}
- (NSURL *)ubiquitousDocumentsURL
{
    NSURL *url = [self.iCloudUbiquitousURL URLByAppendingPathComponent:@"Documents" isDirectory:YES];
    [self directoryExistCheck:url];
    return url;
}
- (NSURL *)ubiquitousDocumentsCetaceaURL
{
    NSURL *url = [[self ubiquitousDocumentsURL] URLByAppendingPathComponent:@"Cetacea" isDirectory:YES];
    [self directoryExistCheck:url];
    return url;
}
- (NSURL *)ubiquitousDocumentsHighlightThemesURL
{
    NSURL *url = [[self ubiquitousDocumentsURL] URLByAppendingPathComponent:@"HighLightThemes" isDirectory:YES];
    [self directoryExistCheck:url];
    return url;
}
- (void)directoryExistCheck:(NSURL *)url
{
    NSString *path = [url path];
    NSError *error;
    BOOL *isDirectory = NULL;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:isDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    }
}
- (BOOL)isIcloudAvailiable
{
    return !([[NSFileManager defaultManager] ubiquityIdentityToken] == nil);
}

#pragma mark - iCloud Query Notification
- (void)ubiquityIdentityDidChanged:(NSNotification *)notification
{
    
}
- (void)didStartGatheriCloudFiles:(NSNotification *)notification
{
    NSLog(@"didStartGatheriCloudFiles");
}
- (void)didGatheringiCloudFiles:(NSNotification *)notification
{
    NSLog(@"didGatheringiCloudFiles");
}

- (void)didUpdateiCloudFiles:(NSNotification *)notification
{
    NSLog(@"didUpdateiCloudFiles");
    
    NSMetadataQuery *query = [notification object];
    
    if (query == self.iCloudCetaceaFilesMetadataQuery)
    {
        [query disableUpdates];
        NSLog(@"iCloudCetaceaFilesMetadataQuery resultCount = %lu", (unsigned long)query.resultCount);
        NSArray * queryResults = [query results];
        id<CSFiCloudSyncDelegate> strongDelegate = self.delegate;
        [strongDelegate iCloudFileUpdated:query];
        
        [query enableUpdates];
    }
}
@end
