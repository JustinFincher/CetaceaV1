//
//  CSFiCloudFileExtensionCetaceaThemeSharedDocument.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
#import "CSFGlobalHeader.h"

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define CSFCetaceaThemeSharedDocument CSFiCloudFileExtensionCetaceaThemeUIDocument
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define CSFCetaceaThemeSharedDocument CSFiCloudFileExtensionCetaceaThemeNSDocument
#endif

@class CSFiCloudFileExtensionCetaceaThemeSharedDocument;

@interface CSFCetaceaThemeSharedDocument : CSFDocument
@property (weak) CSFiCloudFileExtensionCetaceaThemeSharedDocument *sharedDocument;
#if TARGET_OS_IOS
- (id)initWithFileURL:(NSURL *)url
   withSharedDocument:(CSFiCloudFileExtensionCetaceaThemeSharedDocument *)doc;
#elif TARGET_OS_OSX
- (id)initWithContentsOfURL:(NSURL *)url
                     ofType:(NSString *)typeName
                      error:(NSError * _Nullable *)outError
         withSharedDocument:(CSFiCloudFileExtensionCetaceaThemeSharedDocument *_Nonnull)doc;
#endif
@end


@interface CSFiCloudFileExtensionCetaceaThemeSharedDocument : NSObject

#pragma mark - File Task
+ (CSFiCloudFileExtensionCetaceaThemeSharedDocument *)newDocument;
- (BOOL)saveDocument;
- (void)deleteDocument:(void (^)(BOOL isSuccessful))completed;

#pragma mark - Compare
- (BOOL)isEqual:(id)object;
- (BOOL)scriptingIsEqualTo:(id)object;

#pragma mark - IO
- (void)updateFileWrappers;

#pragma mark - Property
@property (nonatomic,strong) CSFCetaceaThemeSharedDocument *document;
@property (nonatomic,strong) NSFileWrapper *fileWrapper;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSDate *creationDate;
@property (nonatomic,strong) NSDate *lastChangeDate;

@property (nonatomic,weak) NSMetadataItem *metaDataItem;

@property (nonatomic) BOOL isUploading;
@property (nonatomic) BOOL isUploaded;
@property (nonatomic) BOOL isDownloading;
@property (nonatomic) BOOL isDownloaded;

@end
