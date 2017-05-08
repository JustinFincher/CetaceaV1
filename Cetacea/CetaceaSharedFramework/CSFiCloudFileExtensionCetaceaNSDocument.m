//
//  JZiCloudFileExtensionCetaceaNSDocument.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import "CSFiCloudFileExtensionCetaceaNSDocument.h"

@implementation CSFiCloudFileExtensionCetaceaNSDocument

#pragma mark - Save / Load from NSFileWrapper
- (NSFileWrapper *)fileWrapperOfType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
{
    return self.sharedDocument.fileWrapper;
}

- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
{
    self.sharedDocument.fileWrapper = fileWrapper;
    
    NSFileWrapper *subFileWrapper;
    NSData *data;
    
    subFileWrapper = [fileWrapper.fileWrappers objectForKey:@"title"];
    data = [subFileWrapper regularFileContents];
    self.sharedDocument.title = [[NSString alloc] initWithData:data
                                       encoding:NSUTF8StringEncoding];
    
    subFileWrapper = [fileWrapper.fileWrappers objectForKey:@"markdownString"];
    data = [subFileWrapper regularFileContents];
    self.sharedDocument.markdownString = [[NSString alloc] initWithData:data
                                                encoding:NSUTF8StringEncoding];
    
    self.sharedDocument.title = self.sharedDocument.title ? self.sharedDocument.title : @"";
    self.sharedDocument.markdownString = self.sharedDocument.markdownString ? self.sharedDocument.markdownString : @"";
    
    return YES;
}

+ (BOOL)autosavesInPlace
{
    return YES;
}
@end
