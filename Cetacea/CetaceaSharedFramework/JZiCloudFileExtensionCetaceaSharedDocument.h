//
//  JZiCloudFileExtensionCetaceaSharedDocument.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#import "JZiCloudFileExtensionCetaceaUIDocument.h"
#define SharedDocument JZiCloudFileExtensionCetaceaUIDocument
#else
#import <AppKit/AppKit.h>
#import "JZiCloudFileExtensionCetaceaNSDocument.h"
#define SharedDocument JZiCloudFileExtensionCetaceaNSDocument
#endif

@interface JZiCloudFileExtensionCetaceaSharedDocument : NSObject

@property (nonatomic,strong) SharedDocument *document;

#pragma mark - File Task
+ (JZiCloudFileExtensionCetaceaSharedDocument *)newDocument;
- (BOOL)saveDocument;
- (void)deleteDocument:(void (^)(BOOL isSuccessful))completed;

#pragma mark - Compare
- (BOOL)isEqual:(JZiCloudFileExtensionCetaceaSharedDocument*)object;

#pragma mark - Property
@property (nonatomic,strong) NSString *markdownString;
@property (nonatomic,strong) NSString *title;

@end
