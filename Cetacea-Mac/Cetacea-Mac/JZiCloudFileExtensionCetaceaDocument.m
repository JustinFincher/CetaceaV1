//
//  JZiCloudFileExtensionCetaceaDocument.m
//  Cetacea
//
//  Created by Justin Fincher on 2016/12/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudFileExtensionCetaceaDocument.h"

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
        self.title = @"";
        self.markdownString = @"";
        self.highLightString = [[NSAttributedString alloc] initWithString:@""];
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
    
    NSFileWrapper *subWrapper;
    NSData *data;
    
    subWrapper = [[fileWrapper fileWrappers] objectForKey:@"markdownString"];
    data = [subWrapper regularFileContents];
    self.markdownString = [NSKeyedUnarchiver unarchiveObjectWithData: data];
    
    subWrapper = [[fileWrapper fileWrappers] objectForKey:@"highLightString"];
    data = [subWrapper regularFileContents];
    self.highLightString = [NSKeyedUnarchiver unarchiveObjectWithData: data];
    
    return YES;
}
- (NSFileWrapper *)documentFileWrapper
{
    if (!_documentFileWrapper)
    {
        _documentFileWrapper = [[NSFileWrapper alloc] initDirectoryWithFileWrappers:[NSDictionary dictionary]];
        [_documentFileWrapper addRegularFileWithContents:[NSKeyedArchiver archivedDataWithRootObject:self.markdownString]
                             preferredFilename:@"markdownString"];
        [_documentFileWrapper addRegularFileWithContents:[NSKeyedArchiver archivedDataWithRootObject:self.highLightString]
                             preferredFilename:@"highLightString"];
    }
    return _documentFileWrapper;
}


+ (BOOL)autosavesInPlace {
    return YES;
}
- (BOOL)isEqualToDocument:(JZiCloudFileExtensionCetaceaDocument *)doc
{
    return [[[doc fileURL] absoluteString] isEqualToString:[[self fileURL] absoluteString]];
        
}
@end
