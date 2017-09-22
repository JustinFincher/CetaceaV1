//
//  JZiCloudStorageProcesser.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudStorageProcesser.h"
#import "JZiCloudStorageManager.h"
#import "JZiCloudFileExtensionCetaceaDataBase.h"

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
    JZLog(@"iCloudFileUpdated");
    NSMutableArray *proccessedResultArray = [[JZiCloudFileExtensionCetaceaDataBase sharedManager] loadDocs];

    id<JZiCloudStorageProcesserDelegate> strongDelegate = self.delegate;
    [strongDelegate iCloudFileProcessed:proccessedResultArray];
}

@end
