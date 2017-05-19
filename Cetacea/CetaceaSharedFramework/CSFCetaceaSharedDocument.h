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
#define CSFCetaceaNativeSharedDocument CSFCetaceaUIDocument
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define CSFCetaceaNativeSharedDocument CSFCetaceaNSDocument
#endif

@class CSFCetaceaAbstractSharedDocument;


/**
 a CSFDocument subclass. Presentation for platform runtime document, this class is used as platform depentdent class and used mainly for file write/read process. For the platform-indepentdent data model, see [CSFCetaceaAbstractSharedDocument](CSFCetaceaAbstractSharedDocument.html)

 ```
 ┌──────────────────────────────────┐
 │      AbstractSharedDocument      │◀─┐
 └──────────────────────────────────┘  │
 ┌──────────────────────────────────┐  │
 │       NativeSharedDocument       │◀─┘
 └──────────────────────────────────┘
 ```

 ## On iOS:
 ````
 CSFDocument = UIDocument
 CSFCetaceaNativeSharedDocument = CSFCetaceaUIDocument
 so CSFCetaceaNativeSharedDocument is a subclass of UIDocumet
 ````
 
 ## On OSX:
 ````
 CSFDocument = NSDocument
 CSFCetaceaNativeSharedDocument = CSFCetaceaNSDocument
 so CSFCetaceaNativeSharedDocument is a subclass of NSDocument
 ````
 */
@interface CSFCetaceaNativeSharedDocument : CSFDocument


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
 When used, contains a [CSFCetaceaNativeSharedDocument](CSFCetaceaNativeSharedDocument.html) property for native (iOS/OSX) event and handles
 ```
 ┌──────────────────────────────────┐
 │      AbstractSharedDocument      │◀─┐
 └──────────────────────────────────┘  │
 ┌──────────────────────────────────┐  │
 │       NativeSharedDocument       │◀─┘
 └──────────────────────────────────┘
 ```
 */
@interface CSFCetaceaAbstractSharedDocument : NSObject

/// Init Method for Already saved document. Just pass file url and filewrapper will handle the rest.
/// @param url The file url
/// @return instance containing infomation of Abstract cetacea document with a native document instance reference.
- (id)initWithURL:(NSURL *)url;

#pragma mark - File Task
/// Used when a add button is pressed or so
/// @return a fresh cetacea document taking up next file path
+ (CSFCetaceaAbstractSharedDocument *)newDocument;
/// Save document
/// @return Is save successful
- (BOOL)saveDocument;
/// Delete Document
/// @param completed success callback
- (void)deleteDocument:(void (^)(BOOL isSuccessful))completed;

#pragma mark - Compare
/// Is Equal to another object
/// @param object object to be compared
/// @return BOOL for is equal or not
- (BOOL)isEqual:(id)object;
- (BOOL)scriptingIsEqualTo:(id)object;

#pragma mark - IO
- (void)updateFileWrappers;

#pragma mark - Property
/// native document presentation reference
@property (nonatomic,strong) CSFCetaceaNativeSharedDocument *document;
/// file wrapper for native IO
@property (nonatomic,strong) NSFileWrapper *fileWrapper;
/// file store url
@property (nonatomic,strong) NSURL *url;
/// markdown string
@property (nonatomic,strong) NSString *markdownString;
@property (nonatomic,strong) NSURL *markdownStringFileURL;
/// title string generated from markdown string
@property (nonatomic,strong) NSString *title;
/// creation date read from system
@property (nonatomic,strong) NSDate *creationDate;
/// last changed date read from system
@property (nonatomic,strong) NSDate *lastChangeDate;

@property (nonatomic,strong) NSArray *tags;


@property (nonatomic,weak) NSMetadataItem *metaDataItem;

@property (nonatomic) BOOL isUploading;
@property (nonatomic) BOOL isUploaded;
@property (nonatomic) BOOL isDownloading;
@property (nonatomic) BOOL isDownloaded;

@end


