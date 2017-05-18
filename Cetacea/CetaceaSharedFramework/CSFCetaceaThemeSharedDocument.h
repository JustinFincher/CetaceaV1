//
//  CSFiCloudFileExtensionCetaceaThemeSharedDocument.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
#import "CSFGlobalHeader.h"
#import "CSFSharedDocumentBase.h"

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define CSFCetaceaNativeSharedDocument CSFCetaceaThemeUIDocument
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define CSFCetaceaNativeSharedDocument CSFCetaceaThemeNSDocument
#endif

@class CSFCetaceaThemeAbstractSharedDocument;

@interface CSFCetaceaNativeSharedDocument : CSFNativeSharedDocument
#pragma mark - Override
- (CSFCetaceaThemeAbstractSharedDocument *)abstractDocument;
@end


@interface CSFCetaceaThemeAbstractSharedDocument : CSFAbstractSharedDocument
#pragma mark - Override
+ (CSFCetaceaThemeAbstractSharedDocument *)newDocument;
- (CSFCetaceaNativeSharedDocument *)nativeDocument;
@end
