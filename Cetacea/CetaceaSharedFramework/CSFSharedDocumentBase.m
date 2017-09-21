//
//  CSFSharedDocumentBase.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/18.
//
//

#import "CSFSharedDocumentBase.h"
#import "CSFiCloudFileDataBase.h"

@implementation CSFNativeSharedDocument
/**
 For Override Return Type
 
 @return a abstract representation of document
 */
- (CSFAbstractSharedDocument *)getAbstractDocument
{
	return (CSFAbstractSharedDocument *)self.abstractDocument;
}
#pragma mark - Init
#if TARGET_OS_IOS
- (id)initWithFileURL:(NSURL *)url withSharedDocument:(CSFAbstractSharedDocument *)doc
{
	self = [super initWithFileURL:url];
	if (self)
	{
		self.abstractDocument = doc;
	}
	return self;
}
#elif TARGET_OS_OSX
- (id)initWithContentsOfURL:(NSURL *)url
					 ofType:(NSString *)typeName
					  error:(NSError * _Nullable *)outError
		 withSharedDocument:(CSFAbstractSharedDocument *_Nonnull)doc
{
	self = [super initWithContentsOfURL:url ofType:typeName error:outError];
	if (self)
	{
		self.abstractDocument = doc;
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
	return [self getAbstractDocument].fileWrapper;
}
#pragma mark - Read
#if TARGET_OS_IOS
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable *)outError
#elif TARGET_OS_OSX
- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
#endif
{
#if TARGET_OS_IOS
	[self getAbstractDocument].fileWrapper = contents;
#elif TARGET_OS_OSX
	[self getAbstractDocument].fileWrapper = fileWrapper;
#endif
	return YES;
}
#pragma mark - Write
#if TARGET_OS_IOS
- (BOOL)writeContents:(id)contents toURL:(NSURL *)url forSaveOperation:(UIDocumentSaveOperation)saveOperation originalContentsURL:(NSURL *)originalContentsURL error:(NSError * _Nullable *)outError
#elif TARGET_OS_OSX
- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
#endif
{
	[[self getAbstractDocument] updateFileWrappers];
	NSError *err;
	BOOL isSucess = [[self getAbstractDocument].fileWrapper writeToURL:url options:NSFileWrapperWritingAtomic | NSFileWrapperWritingWithNameUpdating originalContentsURL:nil error:&err];
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


/**
 Example of how Abstract-Native Shared Document work
 */
@implementation CSFAbstractSharedDocument
- (CSFNativeSharedDocument *)getNativeDocument
{
	return (CSFNativeSharedDocument *)self.nativeDocument;
}
- (Class)getNativeDocumentClass
{
	return [CSFNativeSharedDocument class];
}
- (Class)getDatabaseClass
{
	return [CSFiCloudFileDataBase class];
}
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
		self.nativeDocument = [[[self getNativeDocumentClass] alloc] initWithFileURL:url withSharedDocument:self];
		[self.nativeDocument loadFromContents:self.fileWrapper ofType:@"cetacea" error:&err];
		
#elif TARGET_OS_OSX
		self.nativeDocument = [[[self getNativeDocumentClass] alloc] initWithContentsOfURL:url ofType:@"cetacea" error:nil withSharedDocument:self];
		[self.nativeDocument readFromFileWrapper:self.fileWrapper ofType:@"cetacea" error:&err];
#endif
		if (err)
		{
			JZLog(@"%@",[err localizedDescription]);
		}
		
	}
	return self;
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
+ (NSString *)getNewDocumentNextPath
{
	return [[CSFiCloudFileDataBase sharedManager] nextFilePath];
}
+ (CSFAbstractSharedDocument *)newDocument
{
	NSString *docPath = [self getNewDocumentNextPath];
	NSURL *url = [[NSURL alloc] initFileURLWithPath:docPath isDirectory:YES];
	id doc = [[[self class] alloc] initWithURL:url];
	
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
	[self updateFileWrappers];
	#if TARGET_OS_IOS
	return [self.nativeDocument writeContents:self.fileWrapper toURL:self.url forSaveOperation:UIDocumentSaveForOverwriting originalContentsURL:self.url error:nil];
	#elif TARGET_OS_OSX
	return [self.fileWrapper writeToURL:self.url options:NSFileWrapperWritingAtomic | NSFileWrapperWritingWithNameUpdating originalContentsURL:self.url error:nil];
	#endif
}
#if TARGET_OS_IOS

#elif TARGET_OS_OSX
//- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
//{
//	[self updateFileWrappers];
//	NSError *err;
//	BOOL isSucess = [self.fileWrapper writeToURL:url options:NSFileWrapperWritingAtomic | NSFileWrapperWritingWithNameUpdating originalContentsURL:url error:&err];
//	if (err)
//	{
//		JZLog(@"%@",[err localizedDescription]);
//	}
//	return isSucess;
//}
#endif
- (void)deleteDocument:(void (^)(BOOL isSuccessful))completed
{
	[[NSFileManager defaultManager] removeItemAtURL:self.url error:nil];
	completed(YES);
}
- (BOOL)isEqual:(id)object
{
	if (object == self)
	{
		return YES;
	}
	if ([object respondsToSelector:@selector(url)])
	{
		BOOL isEqual = [[[object valueForKey:@"url"] path] isEqualToString:[[self url] path]];
		return isEqual;
	}
	return NO;
}
- (BOOL)scriptingIsEqualTo:(id)object
{
	if (object == self)
	{
		return YES;
	}
	if ([object respondsToSelector:@selector(url)])
	{
		BOOL isEqual = [[[object valueForKey:@"url"] path] isEqualToString:[[self url] path]];
		return isEqual;
	}
	return NO;
}
- (void)updateFileWrappers
{
	
}
@end
