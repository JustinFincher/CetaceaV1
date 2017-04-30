//
//  JZiCloudFileExtensionCetaceaDocument.m
//  Cetacea
//
//  Created by Justin Fincher on 2016/12/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudFileExtensionCetaceaDocument.h"
#import "JZMainWindowController.h"
#import "JZiCloudFileExtensionCetaceaDataBase.h"

@interface JZiCloudFileExtensionCetaceaDocument ()

@end

@implementation JZiCloudFileExtensionCetaceaDocument

/*
- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return <#nibName#>;
}
*/

- (void)makeWindowControllers
{
    BOOL hasWindow = NO;
    for (NSWindow *window in [[NSApplication sharedApplication] windows])
    {
        if ([window.contentViewController isKindOfClass:[JZMainWindowController class]])
        {
            hasWindow = YES;
            JZMainWindowController *controller = (JZMainWindowController *)window.contentViewController;
            [self addWindowController:controller];
        }
    }
    if (!hasWindow)
    {
        NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        JZMainWindowController *controller = [sb instantiateControllerWithIdentifier:@"JZMainWindowController"];
        [self addWindowController:controller];
    }
}

- (id)init
{
    if ([super init])
    {
    }
    return self;
}
- (id)initWithURL:(NSURL *)url
{
    if ([super init])
    {
        self.urlWhenInited = url;
        [self readFromFileWrapper:[self getDocumentFileWrapper] ofType:@"cetacea" error:nil];
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

#pragma mark - Save / Load from NSFileWrapper
- (NSFileWrapper *)fileWrapperOfType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
{
    return self.documentFileWrapper;
}

- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
{
    self.documentFileWrapper = fileWrapper;
    
    NSFileWrapper *subFileWrapper;
    NSData *data;

    subFileWrapper = [_documentFileWrapper.fileWrappers objectForKey:@"title"];
    data = [subFileWrapper regularFileContents];
    self.title = [[NSString alloc] initWithData:data
encoding:NSUTF8StringEncoding];
//    JZLog(@"Title : %@",_title);
    
    subFileWrapper = [_documentFileWrapper.fileWrappers objectForKey:@"markdownString"];
    data = [subFileWrapper regularFileContents];
    self.markdownString = [[NSString alloc] initWithData:data
                                                encoding:NSUTF8StringEncoding];
//    JZLog(@"MarkdownString : %@",_markdownString);
    
    subFileWrapper = [_documentFileWrapper.fileWrappers objectForKey:@"highLightString"];
    data = [subFileWrapper regularFileContents];
    self.highLightString = [NSKeyedUnarchiver unarchiveObjectWithData: data];
//    JZLog(@"HighLightString : %@",_highLightString);
    
    
    self.title = self.title ? self.title : @"";
    self.markdownString = self.markdownString ? self.markdownString : @"";
    self.highLightString = self.highLightString ? self.highLightString : [[NSAttributedString alloc] initWithString:@""];
    
    return YES;
}

- (NSFileWrapper *)getDocumentFileWrapper
{
    if (self.urlWhenInited)
    {
        NSString *path = [self.urlWhenInited path];
        if (! [[NSWorkspace sharedWorkspace] isFilePackageAtPath:path] )
        {
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        }
    }
    if (!_documentFileWrapper)
    {
        NSError *err;
        self.documentFileWrapper = [[NSFileWrapper alloc] initWithURL:self.urlWhenInited options:0 error:&err];
        if (err)
        {
            JZLog(@"%@",[err localizedDescription]);
        }
    }
    JZLog(@"%@",[self.documentFileWrapper fileWrappers]);
    return self.documentFileWrapper;
}
- (void)updateFileWrappers
{
    [self updateFileWrappersByPreferredFileName:@"title" Contents:[self.title dataUsingEncoding:NSUTF8StringEncoding]];
    [self updateFileWrappersByPreferredFileName:@"markdownString" Contents:[self.markdownString dataUsingEncoding:NSUTF8StringEncoding]];
    [self updateFileWrappersByPreferredFileName:@"highLightString" Contents:[NSKeyedArchiver archivedDataWithRootObject:self.highLightString]];
}
- (void)updateFileWrappersByPreferredFileName:(NSString *)fileName
                                     Contents:(NSData *)data
{
    NSFileWrapper *oldFileWrapper = [_documentFileWrapper.fileWrappers objectForKey:fileName];
    if (oldFileWrapper)
    {
        JZLog(@"updateFileWrappersByPreferredFileName : %@ Has Old File Wrapper : YES",fileName);
        [_documentFileWrapper removeFileWrapper:oldFileWrapper];
    }else
    {
        JZLog(@"updateFileWrappersByPreferredFileName : %@ Has Old File Wrapper : NO",fileName);
    }
    
    [_documentFileWrapper addRegularFileWithContents:data
                               preferredFilename:fileName];
}
- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
{
    [self updateFileWrappers];
    NSError *err;
    BOOL isSucess = [self.documentFileWrapper writeToURL:url options:NSFileWrapperWritingAtomic | NSFileWrapperWritingWithNameUpdating originalContentsURL:url error:&err];
    if (err)
    {
        JZLog(@"%@",[err localizedDescription]);
    }
    return isSucess;
}


+ (JZiCloudFileExtensionCetaceaDocument *)newCetaceaDocument
{
    NSString *docPath = [[JZiCloudFileExtensionCetaceaDataBase sharedManager] nextDocPath];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:docPath isDirectory:YES];
    JZiCloudFileExtensionCetaceaDocument *doc = [[JZiCloudFileExtensionCetaceaDocument alloc] initWithURL:url];
    
    BOOL isSuccess = [doc saveCetaceaDocument];
    if(!isSuccess)
    {
        JZLog(@"Cetacea New Document Save Not Sucess");
        return nil;
    }else
    {
         return doc;
    }
}
- (BOOL)saveCetaceaDocument
{
    NSError *err;
    BOOL isSuccess = [self writeToURL:self.urlWhenInited ofType:@"cetacea" error:&err];
    if (!isSuccess)
    {
        JZLog(@"saveCetaceaDocument Not Success");
    }
    return isSuccess;
}

- (void)deleteCetaceDocument:(void (^)(BOOL isSuccessful))completed
{
#warning Error may not be handled
    [[NSFileManager defaultManager] removeItemAtURL:self.urlWhenInited error:nil];
    completed(YES);
}
+ (BOOL)autosavesInPlace {
    return YES;
}

- (BOOL)isEqualToDocument:(JZiCloudFileExtensionCetaceaDocument *)doc
{
    BOOL isEqual = [[[doc urlWhenInited] path] isEqualToString:[[self urlWhenInited] path]];
    return isEqual;

}
@end
