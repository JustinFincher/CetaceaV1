//
//  JZiCloudFileExtensionCetaceaSharedDocument.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import "CSFCetaceaSharedDocument.h"
#import "CSFGlobalHeader.h"
#import "CSFiCloudFileExtensionCetaceaDataBase.h"
#import <ReactiveObjC/ReactiveObjC.h>

@class CSFCetaceaNativeSharedDocument;

@interface CSFCetaceaAbstractSharedDocument ()

@property (nonatomic,strong) NSNumber *itemPercentDownloaded;
@property (nonatomic,strong) NSNumber *itemPercentUploaded;

@end

@implementation CSFCetaceaAbstractSharedDocument
- (id)initWithURL:(NSURL *)url
{
	if ([super init])
	{
		self.url = url;
		if (self.url)
		{
			NSString *path = [self.url path];
			BOOL isExist = NO;
			BOOL isDirectory = NO;
#if TARGET_OS_IOS
			isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
#elif TARGET_OS_OSX
			isExist = [[NSWorkspace sharedWorkspace] isFilePackageAtPath:path];
#endif
			if (! isExist)
			{
				NSError *error;
				[[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
			}
		}
		if (!self.fileWrapper)
		{
			NSError *err;
			self.fileWrapper = [[NSFileWrapper alloc] initWithURL:self.url options:0 error:&err];
			if (err)
			{
				JZLog(@"%@",[err localizedDescription]);
			}
		}

		NSError *err;
#if TARGET_OS_IOS
		self.document = [[CSFCetaceaNativeSharedDocument alloc] initWithFileURL:url withSharedDocument:self];
		[self.document loadFromContents:self.fileWrapper ofType:@"cetacea" error:&err];

#elif TARGET_OS_OSX
		self.document = [[CSFCetaceaNativeSharedDocument alloc] initWithContentsOfURL:url ofType:@"cetacea" error:nil withSharedDocument:self];
        [self.document readFromFileWrapper:self.fileWrapper ofType:@"cetacea" error:&err];
#endif
		if (err)
		{
			JZLog(@"%@",[err localizedDescription]);
		}

	}
	return self;
}

- (void)updateFileWrappers
{
	[self updateFileWrappersByPreferredFileName:@"title" Contents:[self.title dataUsingEncoding:NSUTF8StringEncoding]];
	[self updateFileWrappersByPreferredFileName:@"markdownString" Contents:[self.markdownString dataUsingEncoding:NSUTF8StringEncoding]];
	[self updateFileWrappersByPreferredFileName:@"tags" Contents:[NSJSONSerialization dataWithJSONObject:self.tags options:NSJSONWritingPrettyPrinted error:nil]];
}
- (void)updateFileWrappersByPreferredFileName:(NSString *)fileName
                                     Contents:(NSData *)data
{
	NSFileWrapper *oldFileWrapper = [self.fileWrapper.fileWrappers objectForKey:fileName];
	if (oldFileWrapper)
	{
		JZLog(@"updateFileWrappersByPreferredFileName : %@ Has Old File Wrapper : YES",fileName);
		[self.fileWrapper removeFileWrapper:oldFileWrapper];
	}else
	{
		JZLog(@"updateFileWrappersByPreferredFileName : %@ Has Old File Wrapper : NO",fileName);
	}
	[self.fileWrapper addRegularFileWithContents:data
	                           preferredFilename:fileName];
}
#pragma mark - Getter
- (NSNumber *)itemPercentUploaded
{
	return [self.metaDataItem valueForAttribute:NSMetadataUbiquitousItemPercentUploadedKey];
}
- (NSNumber *)itemPercentDownloaded
{
	return [self.metaDataItem valueForAttribute:NSMetadataUbiquitousItemPercentDownloadedKey];
}
#pragma mark - Compare
- (BOOL)isEqual:(id)object
{
	if (object == self)
	{
		return YES;
	}
	BOOL isEqual = [[[(CSFCetaceaAbstractSharedDocument *)object url] path] isEqualToString:[[self url] path]];
	return isEqual;
}
- (BOOL)scriptingIsEqualTo:(id)object
{
	if (object == self)
	{
		return YES;
	}
	BOOL isEqual = [[[(CSFCetaceaAbstractSharedDocument *)object url] path] isEqualToString:[[self url] path]];
	return isEqual;
}
#pragma mark - File Task
+ (CSFCetaceaAbstractSharedDocument *)newDocument
{
	NSString *docPath = [[CSFiCloudFileExtensionCetaceaDataBase sharedManager] nextFilePath];
	NSURL *url = [[NSURL alloc] initFileURLWithPath:docPath isDirectory:YES];
	CSFCetaceaAbstractSharedDocument *doc = [[CSFCetaceaAbstractSharedDocument alloc] initWithURL:url];

	BOOL isSuccess = [doc saveDocument];
	if(!isSuccess)
	{
		JZLog(@"Cetacea New Document Save Not Sucess");
		return nil;
	}else
	{
		return doc;
	}
}
- (BOOL)saveDocument
{
#if TARGET_OS_IOS
    [self.document writeContents:self.fileWrapper toURL:self.url forSaveOperation:UIDocumentSaveForOverwriting originalContentsURL:self.url error:nil];
#elif TARGET_OS_OSX
    [self.document writeToURL:self.url ofType:@"cetacea" error:nil];
#endif
	return YES;
}
- (void)deleteDocument:(void (^)(BOOL isSuccessful))completed
{
	[[NSFileManager defaultManager] removeItemAtURL:self.url error:nil];
	completed(YES);
}

#pragma mark - Properties
- (NSURL *)markdownStringFileURL
{
	return [[self url] URLByAppendingPathComponent:@"markdownString" isDirectory:NO];
}
- (BOOL)isUploading
{
	if (self.metaDataItem)
	{NSNumber *uploadingStatus = [self.metaDataItem valueForAttribute:NSMetadataUbiquitousItemIsUploadingKey];
		return [uploadingStatus boolValue];
	}
	return NO;
}
- (BOOL)isDownloading
{
	if (self.metaDataItem)
	{
		NSString *downloadStatus = [self.metaDataItem valueForAttribute:NSMetadataUbiquitousItemDownloadingStatusKey];
		return ([downloadStatus isEqualToString:NSMetadataUbiquitousItemDownloadingStatusNotDownloaded] || [downloadStatus isEqualToString:NSMetadataUbiquitousItemDownloadingStatusDownloaded]);
	}
	return NO;
}
- (BOOL)isUploaded
{
	if (self.metaDataItem)
	{NSNumber *uploadedStatus = [self.metaDataItem valueForAttribute:NSMetadataUbiquitousItemIsUploadedKey];
		return [uploadedStatus boolValue];
	}
	return NO;
}
- (BOOL)isDownloaded
{
	if (self.metaDataItem)
	{
		NSString *downloadStatus = [self.metaDataItem valueForAttribute:NSMetadataUbiquitousItemDownloadingStatusKey];
		return ([downloadStatus isEqualToString:NSMetadataUbiquitousItemDownloadingStatusCurrent]);
	}
	return NO;
}
@end



@implementation CSFCetaceaNativeSharedDocument

#if TARGET_OS_IOS
- (id)initWithFileURL:(NSURL *)url withSharedDocument:(CSFCetaceaAbstractSharedDocument *)doc
{
	self = [super initWithFileURL:url];
	if (self)
	{
		self.sharedDocument = doc;
	}
	return self;
}
#elif TARGET_OS_OSX
- (id)initWithContentsOfURL:(NSURL *)url
                     ofType:(NSString *)typeName
                      error:(NSError * _Nullable *)outError
         withSharedDocument:(CSFCetaceaAbstractSharedDocument *_Nonnull)doc
{
    self = [super initWithContentsOfURL:url ofType:typeName error:outError];
    if (self)
    {
        self.sharedDocument = doc;
    }
    return self;
}
#endif
#pragma mark - NSFileWrapper
#if TARGET_OS_IOS
- (id)contentsForType:(NSString *)typeName
                error:(NSError * _Nullable *)outError
#elif TARGET_OS_OSX
- (NSFileWrapper *)fileWrapperOfType:(NSString *)typeName
                               error:(NSError * _Nullable __autoreleasing *)outError
#endif
{
	return self.sharedDocument.fileWrapper;
}
#pragma mark - Read
#if TARGET_OS_IOS
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable *)outError
{
	self.sharedDocument.fileWrapper = contents;
#elif TARGET_OS_OSX
	- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
    {
        self.sharedDocument.fileWrapper = fileWrapper;
#endif
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
#pragma mark - Write
#if TARGET_OS_IOS
- (BOOL)writeContents:(id)contents toURL:(NSURL *)url forSaveOperation:(UIDocumentSaveOperation)saveOperation originalContentsURL:(NSURL *)originalContentsURL error:(NSError * _Nullable *)outError
#elif TARGET_OS_OSX
- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
#endif
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

#pragma mark - Others
#if TARGET_OS_IOS
#elif TARGET_OS_OSX
+ (BOOL)autosavesInPlace
    {
        return YES;
    }
#endif
@end
