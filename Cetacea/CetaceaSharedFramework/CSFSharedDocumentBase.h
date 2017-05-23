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


@class CSFAbstractSharedDocument;

/**
 Example of how Abstract-Native Shared Document work
 
 ## Methods to override:

 ### iOS
 ```
– getAbstractDocument
– loadFromContents:ofType:error:
 ```
 
 ### OSX
 ```
– getAbstractDocument
– readFromFileWrapper:ofType:error:
 ```
 
 */
@interface CSFNativeSharedDocument : CSFDocument


@property (weak) id _Nullable abstractDocument;
/**
 For Override Return Type

 @return a abstract representation of document
 */
- (CSFAbstractSharedDocument *_Nonnull)getAbstractDocument;

#if TARGET_OS_IOS

/**
 Init Method

 @param url <#url description#>
 @param doc <#doc description#>
 @return <#return value description#>
 */
- (id _Nullable)initWithFileURL:(NSURL *_Nonnull)url
			 withSharedDocument:(CSFAbstractSharedDocument *_Nonnull)doc;

/**
 @warning must be overrided

 @param contents File Wrapper
 @param typeName File Type
 @param outError Error
 @return Load is success or not
 */
- (BOOL)loadFromContents:(id _Nullable )contents
				  ofType:(NSString *_Nullable)typeName
				   error:(NSError * _Nullable *_Nullable)outError;
#elif TARGET_OS_OSX

/**
 Init Method

 @param url <#url description#>
 @param typeName <#typeName description#>
 @param outError <#outError description#>
 @param doc <#doc description#>
 @return <#return value description#>
 */
- (id)initWithContentsOfURL:(NSURL *)url
					 ofType:(NSString *)typeName
					  error:(NSError * _Nullable *)outError
		 withSharedDocument:(CSFAbstractSharedDocument *_Nonnull)doc;

/**
 @warning must be overrided

 @param fileWrapper File Wrapper
 @param typeName File Name
 @param outError Error
 @return Load is success or not
 */
- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper
					 ofType:(NSString *)typeName
					  error:(NSError * _Nullable __autoreleasing *)outError;
#endif

@end

@protocol CSFAbstractSharedDocumentDelegate <NSObject>

@optional

@end

/**
 Example of how Abstract-Native Shared Document work
 */
@interface CSFAbstractSharedDocument : NSObject
#pragma mark - Init Method
- (id _Nullable )initWithURL:(NSURL *_Nonnull)url;

#pragma mark - New File
/**
 New Document

 @return New Document Instance
 */
+ (CSFAbstractSharedDocument *)newDocument;
/**
 @warning must be overrided

 Override with nextFilePath like:
 ```
 return [[CSFiCloudFileDataBase sharedManager] nextFilePath];
 ```
 */
+ (NSString *)getNewDocumentNextPath;

#pragma mark - Save / Delete
- (BOOL)saveDocument;
- (void)deleteDocument:(void (^)(BOOL isSuccessful))completed;

#pragma mark - Compare
- (BOOL)isEqual:(id)object;
- (BOOL)scriptingIsEqualTo:(id)object;


#pragma mark - Sub files
/**
 @warning must be overrided

 For Override Content
 */
- (void)updateFileWrappers;

#pragma mark - Native Bridge
@property (strong) id nativeDocument;
/**
 @warning must be overrided

 For Override Return Type, like
 
 ```
 return (CSFNativeSharedDocument *)self.nativeDocument;
 ```

 @return a native representation of document
 */
- (CSFNativeSharedDocument *)getNativeDocument;
- (Class)getNativeDocumentClass;
- (Class)getDatabaseClass;

#pragma mark - Property
@property (nonatomic,strong) NSFileWrapper *fileWrapper;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,weak) NSMetadataItem *metaDataItem;

@end
