//
//  CSFiCloudFileExtensionCetaceaDataBase.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import "CSFiCloudFileExtensionCetaceaDataBase.h"
#import "CSFCetaceaSharedDocument.h"
#import "CSFiCloudSyncManager.h"
#import "CSFGlobalHeader.h"

@implementation CSFiCloudFileExtensionCetaceaDataBase
- (NSString *)fileExtensionName
{
    return @"cetacea";
}
- (NSString *)fileContainerFolderName
{
    return @"Cetacea";
}
- (NSMutableArray *)filesFromArray:(NSArray *)query
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
        
        NSNumber *uploadedStatus = [item valueForAttribute:NSMetadataUbiquitousItemIsUploadedKey];
        BOOL isUploaded = [uploadedStatus boolValue];
        NSNumber *uploadingStatus = [item valueForAttribute:NSMetadataUbiquitousItemIsUploadingKey];
        BOOL isUploading = [uploadingStatus boolValue];
        NSString *downloadStatus = [item valueForAttribute:NSMetadataUbiquitousItemDownloadingStatusKey];
        BOOL isNotDownloaded = [downloadStatus isEqualToString:NSMetadataUbiquitousItemDownloadingStatusNotDownloaded];
        
        JZLog(@"\n path = %@\n isSizeValid = %i\n isNotHidden = %i\n isUbiquitous = %i\n hasUnresolvedConflicts = %i\n isNotDownloaded = %i\n isUploaded = %i\n isUploading = %i",path,isSizeValid,isNotHidden,isUbiquitous,hasUnresolvedConflicts,isNotDownloaded,isUploaded,isUploading);
        
        if (isNotDownloaded)
        {
            [[NSFileManager defaultManager] startDownloadingUbiquitousItemAtURL:url error:nil];
        }else
        {
            if (isSizeValid || isUploading)
            {
                if (isNotHidden)
                {
                    CSFCetaceaAbstractSharedDocument *doc = [[CSFCetaceaAbstractSharedDocument alloc] initWithURL:url];
                    doc.metaDataItem = item;
                    doc.creationDate = [item valueForAttribute:NSMetadataItemFSCreationDateKey];
                    doc.lastChangeDate = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
                    [retval addObject:doc];
                }
            }else
            {
                [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
            }
        }
        
    }
    
    return retval;
}


@end
