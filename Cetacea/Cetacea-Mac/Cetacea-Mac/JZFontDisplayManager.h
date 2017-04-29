//
//  JZFontDisplayManager.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/3.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface JZFontDisplayManager : NSObject

/**
 *  get single instance
 *
 *  @return JZFontDisplayManager instance
 */
+ (id)sharedManager;

/**
 *  get user set base-font
 *
 *  @return NSFont user set base font
 */
- (NSFont *)getFont;
- (NSString *)getFontFamilyName;
- (CGFloat)getFontSize;

/**
 *  set the base font
 *
 *  @param font NSFont to set as base font
 */
- (void)setFont:(NSFont *)font;

#pragma mark - Font

- (NSFont *)getHeaderFont;

- (NSFont *)getBoldFont;
- (NSFont *)getItalicFont;
- (NSFont *)getMonospacedFont;
- (NSFont *)getBoldMonospacedFont;

#pragma mark - Color
- (NSColor *)getTextColor;
- (NSColor *)getHeaderColor;
- (NSColor *)getBoldColor;

- (NSColor *)getLinkBackgroundColor;
- (NSColor *)getLinkForegroundColor;

- (NSColor *)getCodeBlockBackgroundColor;
- (NSColor *)getCodeBlockForegroundColor;

- (NSColor *)getRuleTextForegroundColor;
- (NSColor *)getRuleTextForegroundHighLightedColor;
@end
