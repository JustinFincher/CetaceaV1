//
//  JZiCloudFileExtensionCetaceaThemeDataBase.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudFileExtensionCetaceaThemeDataBase.h"
#import "JZiCloudStorageManager.h"
#import "JZHeader.h"

@implementation JZiCloudFileExtensionCetaceaThemeDataBase
+ (id)sharedManager {
    static JZiCloudFileExtensionCetaceaThemeDataBase *sharedMyManager = nil;
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

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

// After @implementation, add new function
- (NSString *)getPrivateDocsDir
{
    NSString *documentsDirectory = [[[JZiCloudStorageManager sharedManager] ubiquitousDocumentsHighlightThemesURL] path];
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    return documentsDirectory;
}

- (NSMutableArray *)loadDocs {
    
    // Get private docs dir
    NSString *documentsDirectory = [self getPrivateDocsDir];
    JZLog(@"Loading from %@", documentsDirectory);
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        JZLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files)
    {
        if ([file.pathExtension compare:@"hightlight" options:NSCaseInsensitiveSearch] == NSOrderedSame)
        {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            JZiCloudFileExtensionCetaceaThemeDoc *doc = [[JZiCloudFileExtensionCetaceaThemeDoc alloc] initWithDocPath:fullPath];
            [retval addObject:doc];
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
        if ([file.pathExtension compare:@"hightlight" options:NSCaseInsensitiveSearch] == NSOrderedSame)
        {
            NSString *fileName = [file stringByDeletingPathExtension];
            maxNumber = MAX(maxNumber, fileName.intValue);
        }
    }
    
    // Get available name
    NSString *availableName = [NSString stringWithFormat:@"%d.hightlight", maxNumber+1];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:availableName];
    JZLog(@"%@",path);
    return path;
    
}
@end
