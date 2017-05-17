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

@class CSFCetaceaAbstractSharedDocument;


/**
 a CSFDocument subclass. Presentation for platform runtime document, this class is used as platform depentdent class and used mainly for file write/read process. For the platform-indepentdent data model, see [CSFCetaceaAbstractSharedDocument](CSFCetaceaAbstractSharedDocument.html)
 
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
@property (weak) CSFCetaceaAbstractSharedDocument *sharedDocument;
#if TARGET_OS_IOS

/**
 Init Method On iOS

 @param url File URL
 @param doc Shared Document
 @return A platform depentdent CSFDocument instance (UIDocument)
 */
- (id)initWithFileURL:(NSURL *)url
   withSharedDocument:(CSFCetaceaAbstractSharedDocument *)doc;
#elif TARGET_OS_OSX
- (id)initWithContentsOfURL:(NSURL *)url
                     ofType:(NSString *)typeName
                      error:(NSError * _Nullable *)outError
         withSharedDocument:(CSFCetaceaAbstractSharedDocument *_Nonnull)doc;
#endif
@end

@protocol CSFCetaceaAbstractSharedDocumentDelegate <NSObject>

@optional

- (void)uploadingStatusChanged;
- (void)downloadingStatusChanged;

@end


/**
 Platform Indepentdent Shared Document Data Model;
 */
@interface CSFCetaceaAbstractSharedDocument : NSObject

- (id)initWithURL:(NSURL *)url;

#pragma mark - File Task
+ (CSFCetaceaAbstractSharedDocument *)newDocument;
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


