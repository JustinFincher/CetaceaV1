//
//  CSFEditorTextFontManager.h
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

@interface CSFEditorTextFontManager : NSObject

/**
 *  get single instance
 *
 *  @return CSFEditorTextFontManager instance
 */
+ (id)sharedManager;

#pragma mark Font Helpers
- (NSArray *)getAllFontInApp;
- (NSArray *)getCanBeSelectedFontInApp;

#pragma mark - Editor Base Font
- (NSString *)getEditorBaseFontFamilyName;
- (CGFloat)getEditorBaseFontSize;
- (void)setEditorBaseFont:(CSFFont *)font;

- (CSFFont *)getEditorBaseFont;
- (CSFFont *)getEditorMonospacedFont;

@end
