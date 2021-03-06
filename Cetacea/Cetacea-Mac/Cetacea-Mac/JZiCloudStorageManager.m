//
//  JZiCloudStorageManager.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/30.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudStorageManager.h"
#import "JZiCloudStorageProcesser.h"

@interface JZiCloudStorageManager()

@property (nonatomic,strong) NSURL *ubiquitousURL;

@end

@implementation JZiCloudStorageManager
@synthesize delegate;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static JZiCloudStorageManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
    
        self.ubiquitousURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
        
        self.metadataQuery = [[NSMetadataQuery alloc] init];
        [self.metadataQuery setSearchScopes:[NSArray arrayWithObject:NSMetadataQueryUbiquitousDocumentsScope]];
        [self.metadataQuery setPredicate:[NSPredicate predicateWithFormat:@"%K like '*'", NSMetadataItemFSNameKey]];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(queryDidFinishGathering:)
                                                     name:NSMetadataQueryDidFinishGatheringNotification
                                                   object:self.metadataQuery];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(queryDidUpdate:)
                                                     name:NSMetadataQueryDidUpdateNotification
                                                   object:self.metadataQuery];
        
        [self.metadataQuery startQuery];
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

#pragma mark - Propoties

- (NSURL *)ubiquitousURL
{
    return _ubiquitousURL;
}
- (NSURL *)ubiquitousDocumentsURL
{
    return [_ubiquitousURL URLByAppendingPathComponent:@"Documents" isDirectory:YES];
}
- (NSURL *)ubiquitousDocumentsCetaceaURL
{
    return [[self ubiquitousDocumentsURL] URLByAppendingPathComponent:@"Cetacea" isDirectory:YES];
}
- (NSURL *)ubiquitousDocumentsHighlightThemesURL
{
    return [[self ubiquitousDocumentsURL] URLByAppendingPathComponent:@"HighLightThemes" isDirectory:YES];
}
#pragma mark - iCloud Query Notification

- (void)queryDidFinishGathering:(NSNotification *)notification {
    NSMetadataQuery *query = [notification object];
   
//    NSArray *array = query.results;
//    NSUInteger intter = query.resultCount;
    
    [self loadData:query];
    
}
- (void)queryDidUpdate:(NSNotification *)notification {
    NSMetadataQuery *query = [notification object];
//    
//    NSArray *array = query.results;
//    NSUInteger intter = query.resultCount;
    
    [self loadData:query];


}

- (void)loadData:(NSMetadataQuery *)query {
    
//    [query disableUpdates];
    id<JZiCloudStorageManagerDelegate> strongDelegate = self.delegate;
    [strongDelegate iCloudFileUpdated:query];
//    [query enableUpdates];
}

@end
