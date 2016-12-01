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

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

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
- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
{
    NSFileWrapper *wrapper;
    NSData *data;
    
    wrapper = [[fileWrapper fileWrappers] objectForKey:@"markdownString"];
    data = [wrapper regularFileContents];
    self.markdownString = [NSKeyedUnarchiver unarchiveObjectWithData: data];
    
    wrapper = [[fileWrapper fileWrappers] objectForKey:@"highLightString"];
    data = [wrapper regularFileContents];
    self.highLightString = [NSKeyedUnarchiver unarchiveObjectWithData: data];
    
    return YES;
}
- (NSFileWrapper *)fileWrapperOfType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
{
    NSFileWrapper *dirWrapper = [[NSFileWrapper alloc]
                                  initDirectoryWithFileWrappers:[NSDictionary dictionary]];
    
    [dirWrapper addRegularFileWithContents:[NSKeyedArchiver archivedDataWithRootObject:self.markdownString]
                         preferredFilename:@"markdownString"];
    [dirWrapper addRegularFileWithContents:[NSKeyedArchiver archivedDataWithRootObject:self.highLightString]
                         preferredFilename:@"highLightString"];
    
    return dirWrapper;
}

+ (BOOL)autosavesInPlace {
    return YES;
}

@end
