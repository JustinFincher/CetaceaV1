//
//  CSFiCloudFileExtensionCetaceaDataBase.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import "CSFiCloudFileExtensionCetaceaDataBase.h"
#import "CSFiCloudFileExtensionCetaceaSharedDocument.h"
#import "CSFiCloudSyncManager.h"
#import "CSFGlobalHeader.h"

@implementation CSFiCloudFileExtensionCetaceaDataBase

+ (id)sharedManager {
    static CSFiCloudFileExtensionCetaceaDataBase *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
    }
    return self;
}


// After @implementation, add new function
- (NSString *)getPrivateDocsDir
{
    NSString *documentsDirectory = [[[CSFiCloudSyncManager sharedManager] ubiquitousDocumentsCetaceaURL] path];
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    return documentsDirectory;
    
}
- (NSMutableArray *)loadDocsFromQuery:(NSArray *)query
{
    NSMutableArray *retval = [NSMutableArray array];
    for (NSMetadataItem *item in query)
    {
        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
        NSNumber *fileSize = [item valueForAttribute:NSMetadataItemFSSizeKey];
        NSString *path = [item valueForAttribute:NSMetadataItemPathKey];
        NSString *fileName = [item valueForAttribute:NSMetadataItemFSNameKey];
        NSString *displayName = [item valueForAttribute:NSMetadataItemDisplayNameKey];
        BOOL isSizeValid = ([fileSize longValue] > 0);
        
        NSNumber * isHiddenValue = nil;
        NSError *err;
        [url getResourceValue:&isHiddenValue forKey:NSURLIsHiddenKey error:&err];
        BOOL isNotHidden = (isHiddenValue && ![isHiddenValue boolValue]);
        
        BOOL isUbiquitous = [[item valueForAttribute:NSMetadataItemIsUbiquitousKey] boolValue];
        BOOL hasUnresolvedConflicts = [[item valueForAttribute:NSMetadataUbiquitousItemHasUnresolvedConflictsKey] boolValue];
        NSString *downloadStatus = [item valueForAttribute:NSMetadataUbiquitousItemDownloadingStatusKey];
        BOOL isNotDownloaded = [downloadStatus isEqualToString:NSMetadataUbiquitousItemDownloadingStatusNotDownloaded];
        
        CSFiCloudFileExtensionCetaceaSharedDocument *doc = [[CSFiCloudFileExtensionCetaceaSharedDocument alloc] initWithURL:url];
        doc.metaDataItem = item;
        doc.creationDate = [item valueForAttribute:NSMetadataItemFSCreationDateKey];
        doc.lastChangeDate = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
        
        if (isNotHidden)
        {
            if (isNotDownloaded)
            {
                [[NSFileManager defaultManager] startDownloadingUbiquitousItemAtURL:url error:nil];
            }else
            {
                if (isSizeValid)
                {
                    [retval addObject:doc];
                }
                
            }
        }
        
    }
    return retval;
}

- (NSString *)nextDocPath {
    
    // Get private docs dir
    NSString *documentsDirectory = [self getPrivateDocsDir];
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        JZLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Search for an available name
    int maxNumber = 0;
    for (NSString *file in files) {
        if ([file.pathExtension compare:@"cetacea" options:NSCaseInsensitiveSearch] == NSOrderedSame)
        {
            NSString *fileName = [file stringByDeletingPathExtension];
            maxNumber = MAX(maxNumber, fileName.intValue);
        }
    }
    
    // Get available name
    NSString *availableName = [NSString stringWithFormat:@"%d.cetacea", maxNumber+1];
    return [documentsDirectory stringByAppendingPathComponent:availableName];
    
}



@end
