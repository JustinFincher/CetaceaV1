//
//  JZiCloudStorageProcesser.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudStorageProcesser.h"
#import "JZiCloudStorageManager.h"
#import "JZiCloudMarkdownFileModel.h"

@interface JZiCloudStorageProcesser()<JZiCloudStorageManagerDelegate>

@end

@implementation JZiCloudStorageProcesser

#pragma mark Singleton Methods

+ (id)sharedManager {
    static JZiCloudStorageProcesser *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        JZiCloudStorageManager *iCloudStorageManager = (JZiCloudStorageManager *)[JZiCloudStorageManager sharedManager];
        iCloudStorageManager.delegate = self;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


#pragma mark - JZiCloudStorageManagerDelegate

- (void)iCloudFileUpdated:(NSMetadataQuery *)query
{
    NSMutableArray *proccessedResultArray = [NSMutableArray array];
    for (int i = 0; i < [query resultCount]; i++)
    {
        NSMetadataItem *item = [query resultAtIndex:i];
        JZiCloudMarkdownFileModel *markdown = [[JZiCloudMarkdownFileModel alloc] init];
        [markdown setMetaDataItem:item];
        [proccessedResultArray addObject:markdown];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"updatedDate" ascending:NO];
    [proccessedResultArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

    id<JZiCloudStorageProcesserDelegate> strongDelegate = self.delegate;
    [strongDelegate iCloudFileProcessed:proccessedResultArray];
}

@end
