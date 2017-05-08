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
#define SharedDocument JZiCloudFileExtensionCetaceaUIDocument
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define SharedDocument JZiCloudFileExtensionCetaceaNSDocument
#endif

@class SharedDocument;
@interface CSFiCloudFileExtensionCetaceaSharedDocument : NSObject

@property (nonatomic,strong) SharedDocument *document;

#pragma mark - File Task
+ (CSFiCloudFileExtensionCetaceaSharedDocument *)newDocument;
- (BOOL)saveDocument;
- (void)deleteDocument:(void (^)(BOOL isSuccessful))completed;

#pragma mark - Compare
- (BOOL)isEqual:(CSFiCloudFileExtensionCetaceaSharedDocument*)object;

#pragma mark - Property
@property (nonatomic, strong) NSFileWrapper *fileWrapper;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSString *markdownString;
@property (nonatomic,strong) NSString *title;

@end
