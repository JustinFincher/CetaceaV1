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

/**
 *  get user set base-font
 *
 *  @return NSFont user set base font
 */
- (CSFFont *)getFont;
- (NSString *)getFontFamilyName;
- (CGFloat)getFontSize;

/**
 *  set the base font
 *
 *  @param font CSFFont to set as base font
 */
- (void)setFont:(CSFFont *)font;

@end
