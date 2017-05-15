//
//  JZiCloudFileExtensionCetaceaSharedDocument.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define CSFDocument UIDocument
#define CSFSharedDocument CSFiCloudFileExtensionCetaceaUIDocument
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define CSFDocument NSDocument
#define CSFSharedDocument CSFiCloudFileExtensionCetaceaNSDocument
#endif

@class CSFSharedDocument;

@protocol CSFiCloudFileExtensionCetaceaSharedDocumentDelegate <NSObject>

@optional

- (void)uploadingStatusChanged;
- (void)downloadingStatusChanged;

@end


@interface CSFiCloudFileExtensionCetaceaSharedDocument : NSObject

- (id)initWithURL:(NSURL *)url;

#pragma mark - File Task
+ (CSFiCloudFileExtensionCetaceaSharedDocument *)newDocument;
- (BOOL)saveDocument;
- (void)deleteDocument:(void (^)(BOOL isSuccessful))completed;

#pragma mark - Compare
- (BOOL)isEqual:(id)object;
- (BOOL)scriptingIsEqualTo:(id)object;

#pragma mark - IO
- (void)updateFileWrappers;

#pragma mark - Property
@property (nonatomic,strong) CSFSharedDocument *document;
@property (nonatomic,strong) NSFileWrapper *fileWrapper;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSString *markdownString;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSDate *creationDate;
@property (nonatomic,strong) NSDate *lastChangeDate;

@property (nonatomic,strong) NSArray *tags;


@property (nonatomic,weak) NSMetadataItem *metaDataItem;

@property (nonatomic) BOOL isUploading;
@property (nonatomic) BOOL isUploaded;
@property (nonatomic) BOOL isDownloading;
@property (nonatomic) BOOL isDownloaded;

@end

@interface CSFSharedDocument : CSFDocument
@property (weak) CSFiCloudFileExtensionCetaceaSharedDocument *sharedDocument;
#if TARGET_OS_IOS
- (id)initWithFileURL:(NSURL *)url
   withSharedDocument:(CSFiCloudFileExtensionCetaceaSharedDocument *)doc;
#elif TARGET_OS_OSX
- (id)initWithContentsOfURL:(NSURL *)url
                     ofType:(NSString *)typeName
                      error:(NSError * _Nullable *)outError
         withSharedDocument:(CSFiCloudFileExtensionCetaceaSharedDocument *_Nonnull)doc;
#endif
@end

