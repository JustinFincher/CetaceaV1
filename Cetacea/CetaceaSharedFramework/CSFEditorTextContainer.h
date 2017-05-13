//
//  CSFEditorTextContainer.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/13.
//
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#elif TARGET_OS_OSX
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#endif
@interface CSFEditorTextContainer : NSTextContainer

@end
