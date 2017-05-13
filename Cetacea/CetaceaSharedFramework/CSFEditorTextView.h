//
//  CSFEditorTextView.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/12.
//
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define EditorTextViewClass UITextView
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define EditorTextViewClass NSTextView
#endif

#import "CSFiCloudFileExtensionCetaceaSharedDocument.h"

@interface CSFEditorTextView : EditorTextViewClass

@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaSharedDocument *currentEditingDocument;

@end
