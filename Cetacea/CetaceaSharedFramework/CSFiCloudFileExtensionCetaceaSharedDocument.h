//
//  JZiCloudFileExtensionCetaceaSharedDocument.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import <Foundation/Foundation.h>
#import "CSFGlobalHeader.h"

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define CSFCetaceaSharedDocument CSFiCloudFileExtensionCetaceaUIDocument
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define CSFCetaceaSharedDocument CSFiCloudFileExtensionCetaceaNSDocument
#endif

@class CSFiCloudFileExtensionCetaceaSharedDocument;


/**
 a CSFDocument subclass. Presentation for platform runtime document
 
 ## On iOS:
 ````
 CSFDocument = UIDocument
 CSFCetaceaSharedDocument = CSFiCloudFileExtensionCetaceaUIDocument
 ````
 
 ## On OSX:
 ````
 CSFDocument = NSDocument
 CSFCetaceaSharedDocument = CSFiCloudFileExtensionCetaceaNSDocument
 ````
 */
@interface CSFCetaceaSharedDocument : CSFDocument


/**
 SharedDocument Instance, owner of this class instance
 */
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
@property (nonatomic,strong) CSFCetaceaSharedDocument *document;
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


