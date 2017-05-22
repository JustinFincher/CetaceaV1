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

#import "CSFCetaceaSharedDocument.h"


/**
 CSF EdiorTextView (UITextView / NSTextView)
 */
@interface CSFEditorTextView : EditorTextViewClass

@property (nonatomic,strong) CSFCetaceaAbstractSharedDocument *currentEditingDocument;


/**
 Some Property Init Methods
 */
- (void)setupTextView;

/**
 Refresh Hightlight and store to buffer (not apply to textview yet)
 */
- (void)refreshHightLight;

/**
 Reload Hightlight source from the currentEditingDocument
 */
- (void)refreshFileContent;

/**
 Update TextView Content With Buffer
 */
- (void)updateTextView;

@end
