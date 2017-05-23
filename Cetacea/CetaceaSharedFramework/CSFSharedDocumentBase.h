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
 Pre declare CSFAbstractSharedDocument in front of CSFNativeSharedDocument
 */
@class CSFAbstractSharedDocument;


/**
 Base Class of Native Part of how Abstract-Native Shared Document work

 - Inherits from CSFDocument
	 - On iOS CSFDocument => UIKit.UIDocument
	 - On OSX CSFDocument => AppKit.NSDocument
 
 - SeeAlso:
 CSFAbstractSharedDocument
 
 
 ## Methods to override:

 ### iOS

 – getAbstractDocument
 
 **OVERRIDE EXAMPLE**

	- (TargetCSFAbstractSharedDocumentClass *)getAbstractDocument
	{
		return (TargetCSFAbstractSharedDocumentClass *)self.abstractDocument;
	}

– loadFromContents:ofType:error:
 
 **OVERRIDE EXAMPLE**

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

 
 ### OSX
 ```
 – getAbstractDocument

 **OVERRIDE EXAMPLE**
 
	- (TargetCSFAbstractSharedDocumentClass *)getAbstractDocument
	{
		return (TargetCSFAbstractSharedDocumentClass *)self.abstractDocument;
	}
 
 – readFromFileWrapper:ofType:error:
 
 **OVERRIDE EXAMPLE**

	- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
	{
		self.sharedDocument.fileWrapper = fileWrapper;
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
 ```
 
 */
@interface CSFNativeSharedDocument : CSFDocument


/**
 Abstract Document Reference
 */
@property (weak) id _Nullable abstractDocument;
/**
 For Override Return Type

 @return a abstract representation of document
 */
- (CSFAbstractSharedDocument *_Nonnull)getAbstractDocument;

#if TARGET_OS_IOS

/**
 Init Method

 @param url File URL
 @param doc CSFAbstractSharedDocument instance
 @return native sharedDocument intance
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

 @param url File URL
 @param typeName file type
 @param outError Error
 @param doc CSFAbstractSharedDocument instance
 @return native sharedDocument intance
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


/**
 Delegate For Abstract Shared Document
 */
@protocol CSFAbstractSharedDocumentDelegate <NSObject>

@optional

@end

/**
 Base Class of Abstract Part of how Abstract-Native Shared Document work
 
 - SeeAlso:
 CSFNativeSharedDocument
 

 ## Methods to override:
 
 + getNewDocumentNextPath
 **Override with TargetCSFiCloudFileDataBaseClass.nextFilePath**
		+ (NSString *)getNewDocumentNextPath
		{
			return [[TargetCSFiCloudFileDataBaseClass sharedManager] nextFilePath];
		}
 
 - updateFileWrappers
 **Override with updateFileWrappersByPreferredFileName:Contents:**
		- (void)updateFileWrappers
		{
			[self updateFileWrappersByPreferredFileName:@"title" Contents:[self.title dataUsingEncoding:NSUTF8StringEncoding]];
			[self updateFileWrappersByPreferredFileName:@"markdownString" Contents:[self.markdownString dataUsingEncoding:NSUTF8StringEncoding]];
			[self updateFileWrappersByPreferredFileName:@"tags" Contents:[NSJSONSerialization dataWithJSONObject:self.tags options:NSJSONWritingPrettyPrinted error:nil]];
		}
 
 - getNativeDocument
 **Override Example**
		- (TargetCSFNativeSharedDocumentClass *)getNativeDocument
		{
			return (TargetCSFNativeSharedDocumentClass *)self.nativeDocument;
		}
 
 
 */
@interface CSFAbstractSharedDocument : NSObject
#pragma mark - Init Method

/**
 Init Method For Abstract Document

 @param url File URL
 @return Instance
 */
- (id _Nullable )initWithURL:(NSURL *_Nonnull)url;

#pragma mark - New File
/**
 New Document

 @return New Document Instance
 */
+ (CSFAbstractSharedDocument *)newDocument;
/**
 @warning must be overrided
 
 **Override with nextFilePath**:

		return [[CSFiCloudFileDataBase sharedManager] nextFilePath];
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
