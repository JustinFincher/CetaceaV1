//
//  JZiCloudFileExtensionCetaceaUIDocument.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import "CSFiCloudFileExtensionCetaceaUIDocument.h"
#import "CSFGlobalHeader.h"

@implementation CSFiCloudFileExtensionCetaceaUIDocument

- (id)initWithFileURL:(NSURL *)url withSharedDocument:(CSFiCloudFileExtensionCetaceaSharedDocument *)doc
{
    self = [super initWithFileURL:url];
    if (self)
    {
        self.sharedDocument = doc;
    }
    return self;
}
#pragma mark - Save / Load from NSFileWrapper
- (id)contentsForType:(NSString *)typeName error:(NSError * _Nullable *)outError
{
    return self.sharedDocument.fileWrapper;
}
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable *)outError
{
    self.sharedDocument.fileWrapper = contents;
    
    NSFileWrapper *subFileWrapper;
    NSData *data;
    
    subFileWrapper = [self.sharedDocument.fileWrapper.fileWrappers objectForKey:@"title"];
    data = [subFileWrapper regularFileContents];
    NSString *title = [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
    self.sharedDocument.title = title;
    
    subFileWrapper = [self.sharedDocument.fileWrapper.fileWrappers objectForKey:@"markdownString"];
    data = [subFileWrapper regularFileContents];
    NSString *markdownString = [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
    self.sharedDocument.markdownString = markdownString;
    
    self.sharedDocument.title = self.sharedDocument.title ? self.sharedDocument.title : @"";
    self.sharedDocument.markdownString = self.sharedDocument.markdownString ? self.sharedDocument.markdownString : @"";
    
    return YES;
}
- (BOOL)writeContents:(id)contents toURL:(NSURL *)url forSaveOperation:(UIDocumentSaveOperation)saveOperation originalContentsURL:(NSURL *)originalContentsURL error:(NSError * _Nullable *)outError
{
    [self.sharedDocument updateFileWrappers];
    NSError *err;
    BOOL isSucess = [self.sharedDocument.fileWrapper writeToURL:url options:NSFileWrapperWritingAtomic | NSFileWrapperWritingWithNameUpdating originalContentsURL:nil error:&err];
    if (err)
    {
        JZLog(@"%@",[err localizedDescription]);
    }
    return isSucess;
}
@end
