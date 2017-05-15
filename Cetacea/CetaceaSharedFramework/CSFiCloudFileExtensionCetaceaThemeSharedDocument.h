//
//  CSFiCloudFileExtensionCetaceaThemeSharedDocument.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define SharedDocument CSFiCloudFileExtensionCetaceaThemeUIDocument
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define SharedDocument CSFiCloudFileExtensionCetaceaThemeNSDocument
#endif

@class SharedDocument;


@interface CSFiCloudFileExtensionCetaceaThemeSharedDocument : NSObject



@end
