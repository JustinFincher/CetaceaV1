//
//  JZiCloudFileExtensionCetaceaNSDocument.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import "CSFiCloudFileExtensionCetaceaSharedDocument.h"

@interface CSFiCloudFileExtensionCetaceaNSDocument : NSDocument

@property (weak) CSFiCloudFileExtensionCetaceaSharedDocument *sharedDocument;

- (id)initWithContentsOfURL:(NSURL *)url
                     ofType:(NSString *)typeName
                      error:(NSError * _Nullable *)outError
         withSharedDocument:(CSFiCloudFileExtensionCetaceaSharedDocument *_Nonnull)doc;

@end
