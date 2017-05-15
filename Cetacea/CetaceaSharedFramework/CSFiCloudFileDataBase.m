//
//  CSFiCloudFileDataBase.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import "CSFiCloudFileDataBase.h"
#import "CSFiCloudSyncManager.h"
#import "CSFGlobalHeader.h"

@implementation CSFiCloudFileDataBase

+ (id)sharedManager {
    static CSFiCloudFileDataBase *sharedMyManager = nil;
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

- (NSString *)getPrivateDocsDir
{
    NSURL *documentsDirectoryURL = [[[CSFiCloudSyncManager sharedManager] ubiquitousDocumentsURL] URLByAppendingPathComponent:[self fileContainerFolderName] isDirectory:YES];
    [[CSFiCloudSyncManager sharedManager] directoryExistCheck:documentsDirectoryURL];
    return [documentsDirectoryURL path];
}

- (NSURL *)nextFileURL
{
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
        if ([file.pathExtension compare:[self fileExtensionName] options:NSCaseInsensitiveSearch] == NSOrderedSame)
        {
            NSString *fileName = [file stringByDeletingPathExtension];
            maxNumber = MAX(maxNumber, fileName.intValue);
        }
    }
    
    // Get available name
    NSString *availableName = [NSString stringWithFormat:@"%d.%@", maxNumber+1,[self fileExtensionName]];
    
    NSURL *documentCetaceaURL = [[CSFiCloudSyncManager sharedManager] ubiquitousDocumentsCetaceaURL];
    return [documentCetaceaURL URLByAppendingPathComponent:availableName];
}

- (NSString *)nextFilePath
{
    return [[self nextFileURL] path];
}

- (NSString *)fileExtensionName
{
    return @"";
}
- (NSString *)fileContainerFolderName
{
    return @"";
}
- (NSMutableArray *)filesFromArray:(NSArray *)query
{
    return [NSMutableArray array];
}

@end
