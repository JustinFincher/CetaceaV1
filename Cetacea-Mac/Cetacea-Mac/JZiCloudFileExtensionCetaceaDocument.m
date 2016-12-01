//
//  JZiCloudFileExtensionCetaceaDocument.m
//  Cetacea
//
//  Created by Justin Fincher on 2016/12/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudFileExtensionCetaceaDocument.h"
#import "JZHeader.h"

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
        [self readFromFileWrapper:self.documentFileWrapper ofType:@"cetacea" error:nil];
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

#pragma mark - Save / Load from NSData
- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:nil];
    }
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:nil];
    }
    return NO;
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
    JZLog(@"Title : %@",_title);
    
    subFileWrapper = [_documentFileWrapper.fileWrappers objectForKey:@"markdownString"];
    data = [subFileWrapper regularFileContents];
    self.markdownString = [[NSString alloc] initWithData:data
                                                encoding:NSUTF8StringEncoding];
    JZLog(@"MarkdownString : %@",_markdownString);
    
    subFileWrapper = [_documentFileWrapper.fileWrappers objectForKey:@"highLightString"];
    data = [subFileWrapper regularFileContents];
    self.highLightString = [NSKeyedUnarchiver unarchiveObjectWithData: data];
    JZLog(@"HighLightString : %@",_highLightString);
    
    
    self.title = self.title ? self.title : @"";
    self.markdownString = self.markdownString ? self.markdownString : @"";
    self.highLightString = self.highLightString ? self.highLightString : [[NSAttributedString alloc] initWithString:@""];
    
    return YES;
}

- (NSFileWrapper *)documentFileWrapper
{
    if (!_documentFileWrapper)
    {
        _documentFileWrapper = [[NSFileWrapper alloc] initWithURL:self.urlWhenInited options:0 error:nil];
    }
    JZLog(@"%@",[_documentFileWrapper fileWrappers]);
    return _documentFileWrapper;
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
    return [self.documentFileWrapper writeToURL:url options:NSFileWrapperWritingAtomic originalContentsURL:nil error:outError];
}
- (BOOL)save
{
    return [self writeToURL:self.urlWhenInited ofType:@"cetacea" error:nil];
}
+ (BOOL)autosavesInPlace {
    return YES;
}

- (BOOL)isEqualToDocument:(JZiCloudFileExtensionCetaceaDocument *)doc
{
    BOOL isEqual = [[[doc urlWhenInited] absoluteString] isEqualToString:[[self urlWhenInited] absoluteString]];
    return isEqual;

}
@end
