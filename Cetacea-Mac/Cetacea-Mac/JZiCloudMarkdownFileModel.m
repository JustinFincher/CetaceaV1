//
//  JZiCloudMarkdownFileModel.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudMarkdownFileModel.h"

@implementation JZiCloudMarkdownFileModel

- (void)refreshFileStatus
{
    self.isUploaded = [[_metaDataItem valueForAttribute:NSMetadataUbiquitousItemIsUploadedKey] boolValue];
    
    NSString *metadataUbiquitousItemDownloadingStatusKey = [_metaDataItem valueForAttribute:NSMetadataUbiquitousItemDownloadingStatusKey];
    
    if (metadataUbiquitousItemDownloadingStatusKey == NSMetadataUbiquitousItemDownloadingStatusCurrent)
    {
        self.isDownloaded = YES;
        self.isUpToDate = YES;
    
    }else if (metadataUbiquitousItemDownloadingStatusKey == NSMetadataUbiquitousItemDownloadingStatusDownloaded)
    {
        self.isDownloaded = YES;
        self.isUpToDate = NO;
    }
    else if(metadataUbiquitousItemDownloadingStatusKey == NSMetadataUbiquitousItemDownloadingStatusNotDownloaded)
    {
        self.isDownloaded = NO;
        self.isUpToDate = NO;
    }
    
    self.url = [_metaDataItem valueForAttribute:NSMetadataItemURLKey];
    
    if (!self.isDownloaded)
    {
        //download
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] initWithFilePresenter:nil];
        NSError *error;
        [fileCoordinator coordinateReadingItemAtURL:self.url
                                            options:NSFileCoordinatorReadingWithoutChanges
                                              error:&error
                                         byAccessor:^(NSURL *newURL)
         {
             if (newURL)
             {
                 //get new url, ready to download
                 //NSLog(@"%@",[newURL path]);
             }
         }];
    }
    
    self.previewString = [NSString stringWithContentsOfFile:[self.url path] encoding:NSUTF8StringEncoding error:nil];
    
    self.creationDate = [_metaDataItem valueForAttribute:NSMetadataItemFSCreationDateKey];
    self.updatedDate = [_metaDataItem valueForAttribute:NSMetadataItemFSContentChangeDateKey];
    //NSLog(@"%@",self.creationDate);
    NSLog(@"%@",self.updatedDate);
}

- (void)setMetaDataItem:(NSMetadataItem *)metaDataItem
{
    _metaDataItem = metaDataItem;
    [self refreshFileStatus];
}

@end
