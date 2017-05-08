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
#if TARGET_OS_IOS
#import "CSFiCloudFileExtensionCetaceaUIDocument.h"
#elif TARGET_OS_OSX
#import "CSFiCloudFileExtensionCetaceaNSDocument.h"
#endif


@implementation CSFiCloudFileExtensionCetaceaSharedDocument

- (id)initWithURL:(NSURL *)url
{
    if ([super init])
    {
        self.url = url;
        NSFileWrapper *wrapper = self.fileWrapper;
        
        NSError *err;
#if TARGET_OS_IOS
        self.document = [[SharedDocument alloc] initWithFileURL:url withSharedDocument:self];
//        self.document.sharedDocument = self;
        [self.document loadFromContents:self.fileWrapper ofType:@"cetacea" error:&err];
        
#elif TARGET_OS_OSX
        self.document = [[SharedDocument alloc] initWithContentsOfURL:url ofType:@"cetacea" error:nil withSharedDocument:self];
//        self.document.sharedDocument = self;
        [self.document readFromFileWrapper:self.fileWrapper ofType:@"cetacea" error:&err];
#endif
        if (err)
        {
            JZLog(@"%@",[err localizedDescription]);
        }
        
    }
    return self;
}

- (NSFileWrapper *)fileWrapper
{
    if (self.url)
    {
        NSString *path = [self.url path];
        JZLog(@"PATH = %@",path);
        BOOL isExist = NO;
        BOOL isDirectory = NO;
#if TARGET_OS_IOS
        isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
#elif TARGET_OS_OSX
        isExist = [[NSWorkspace sharedWorkspace] isFilePackageAtPath:path];
#endif
        JZLog(@"isExist = %d",isExist);
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
    JZLog(@"[self.fileWrapper fileWrappers] = %@",[_fileWrapper fileWrappers]);
    
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
