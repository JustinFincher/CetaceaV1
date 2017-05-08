//
//  JZiCloudFileExtensionCetaceaSharedDocument.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import "CSFiCloudFileExtensionCetaceaSharedDocument.h"
#import "CSFGlobalHeader.h"
#import "CSFiCloudFileExtensionCetaceaDataBase.h"


@implementation CSFiCloudFileExtensionCetaceaSharedDocument

- (id)initWithURL:(NSURL *)url
{
    if ([super init])
    {
        self.url = url;
    }
    return self;
}

- (NSFileWrapper *)fileWrapper
{
    if (self.url)
    {
        NSString *path = [self.url path];
        BOOL isExist = NO;
#if TARGET_OS_IOS
        isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
#elif TARGET_OS_OSX
        isExist = [[NSWorkspace sharedWorkspace] isFilePackageAtPath:path];
#endif
        if (! isExist)
        {
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        }
    }
    if (!_fileWrapper)
    {
        NSError *err;
        _fileWrapper = [[NSFileWrapper alloc] initWithURL:self.url options:0 error:&err];
        if (err)
        {
            JZLog(@"%@",[err localizedDescription]);
        }
    }
    JZLog(@"%@",[_fileWrapper fileWrappers]);
    return _fileWrapper;
}
- (void)updateFileWrappers
{
    [self updateFileWrappersByPreferredFileName:@"title" Contents:[self.title dataUsingEncoding:NSUTF8StringEncoding]];
    [self updateFileWrappersByPreferredFileName:@"markdownString" Contents:[self.markdownString dataUsingEncoding:NSUTF8StringEncoding]];
}
- (void)updateFileWrappersByPreferredFileName:(NSString *)fileName
                                     Contents:(NSData *)data
{
    NSFileWrapper *oldFileWrapper = [self.fileWrapper.fileWrappers objectForKey:fileName];
    if (oldFileWrapper)
    {
        JZLog(@"updateFileWrappersByPreferredFileName : %@ Has Old File Wrapper : YES",fileName);
        [self.fileWrapper removeFileWrapper:oldFileWrapper];
    }else
    {
        JZLog(@"updateFileWrappersByPreferredFileName : %@ Has Old File Wrapper : NO",fileName);
    }
    [self.fileWrapper addRegularFileWithContents:data
                               preferredFilename:fileName];
}
#pragma mark - Compare
- (BOOL)isEqual:(CSFiCloudFileExtensionCetaceaSharedDocument*)object
{
    BOOL isEqual = [[[object url] path] isEqualToString:[[self url] path]];
    return isEqual;
}

#pragma mark - File Task
+ (CSFiCloudFileExtensionCetaceaSharedDocument *)newDocument
{
    NSString *docPath = [[CSFiCloudFileExtensionCetaceaDataBase sharedManager] nextDocPath];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:docPath isDirectory:YES];
    CSFiCloudFileExtensionCetaceaSharedDocument *doc = [[CSFiCloudFileExtensionCetaceaSharedDocument alloc] initWithURL:url];
    
    BOOL isSuccess = [doc saveDocument];
    if(!isSuccess)
    {
        JZLog(@"Cetacea New Document Save Not Sucess");
        return nil;
    }else
    {
        return doc;
    }
}
- (BOOL)saveDocument
{
    return YES;
}
- (void)deleteDocument:(void (^)(BOOL isSuccessful))completed
{
    [[NSFileManager defaultManager] removeItemAtURL:self.url error:nil];
    completed(YES);
}
@end
