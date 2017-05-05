//
//  CSFiCloudSyncManager.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/1.
//
//

#import "CSFiCloudSyncManager.h"
#import "CSFGlobalHeader.h"


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
        if ([self isIcloudAvailiable])
        {
            NSOperationQueue *quene = [[NSOperationQueue alloc] init];
            [quene addOperationWithBlock:^{
                self.iCloudUbiquitousURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:CSF_String_Identifer_iCloud_Container_Name];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                }];
            }];
        }else
        {
            CSF_Block_Post_Notification_With_No_Object(CSF_String_Notification_iCloud_Not_Availiable_Name)
        }
        
        self.iCloudCetaceaFilesMetadataQuery = [[NSMetadataQuery alloc] init];
        //Cetacea Files Stored in Cetacea sub-folder
        [self.iCloudCetaceaFilesMetadataQuery setSearchScopes:[NSArray arrayWithObject:[[NSURL URLWithString:NSMetadataQueryUbiquitousDocumentsScope] URLByAppendingPathComponent:@"Cetacea" isDirectory:YES]]];
        [self.iCloudCetaceaFilesMetadataQuery setPredicate:[NSPredicate predicateWithFormat:@"%K like '*'", NSMetadataItemFSNameKey]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(queryDidFinishGathering:)
                                                     name:NSMetadataQueryDidFinishGatheringNotification
                                                   object:self.iCloudCetaceaFilesMetadataQuery];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(queryDidUpdate:)
                                                     name:NSMetadataQueryDidUpdateNotification
                                                   object:self.iCloudCetaceaFilesMetadataQuery];
        
        [self.iCloudMetadataQuery startQuery];
    }
    return self;
}

- (void)dealloc
{
    
}

- (BOOL)isIcloudAvailiable
{
    return !([[NSFileManager defaultManager] ubiquityIdentityToken] == nil);
}

#pragma mark - iCloud Query Notification
- (void)queryDidFinishGathering:(NSNotification *)notification
{
    NSMetadataQuery *query = [notification object];
}
- (void)queryDidUpdate:(NSNotification *)notification
{
    NSMetadataQuery *query = [notification object];
}
@end
