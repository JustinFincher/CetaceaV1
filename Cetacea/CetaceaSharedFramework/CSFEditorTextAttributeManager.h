//
//  CSFEditorTextAttributeManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/14.
//
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define CSFFont UIFont
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define CSFFont NSFont
#endif

@interface CSFEditorTextAttributeManager : NSObject

@end
