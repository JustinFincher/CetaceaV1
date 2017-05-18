//
//  CSFSharedDocumentBase.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/18.
//
//

#import <Foundation/Foundation.h>
#import "CSFGlobalHeader.h"


#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define CSFPrefixNativeSharedDocument CSFPrefixUIDocument
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define CSFPrefixNativeSharedDocument CSFPrefixNSDocument
#endif

/**
 Example of how Abstract-Native Shared Document work
 */
@class CSFAbstractSharedDocument;

@interface CSFNativeSharedDocument : CSFDocument

@property (weak) CSFAbstractSharedDocument *sharedDocument;

#if TARGET_OS_IOS
- (id)initWithFileURL:(NSURL *)url
   withSharedDocument:(CSFAbstractSharedDocument *)doc;
#elif TARGET_OS_OSX
- (id)initWithContentsOfURL:(NSURL *)url
					 ofType:(NSString *)typeName
					  error:(NSError * _Nullable *)outError
		 withSharedDocument:(CSFAbstractSharedDocument *_Nonnull)doc;
#endif

@end

@protocol CSFAbstractSharedDocumentDelegate <NSObject>

@optional

@end

/**
 Example of how Abstract-Native Shared Document work
 */
@interface CSFAbstractSharedDocument : NSObject
- (id)initWithURL:(NSURL *)url;
+ (CSFAbstractSharedDocument *)newDocument;
- (BOOL)saveDocument;
- (void)deleteDocument:(void (^)(BOOL isSuccessful))completed;
- (BOOL)isEqual:(id)object;
- (BOOL)scriptingIsEqualTo:(id)object;
- (void)updateFileWrappers;
@property (nonatomic,strong) CSFNativeSharedDocument *nativeDocument;
@property (nonatomic,strong) NSFileWrapper *fileWrapper;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,weak) NSMetadataItem *metaDataItem;
@end
