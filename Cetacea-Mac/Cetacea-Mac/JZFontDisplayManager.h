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

- (NSFont *)getBoldFont;
- (NSFont *)getItalicFont;

/**
 *  set the base font
 *
 *  @param font NSFont to set as base font
 */
- (void)setFont:(NSFont *)font;

- (NSColor *)getTextColor;
- (NSColor *)getHeaderColor;
- (NSColor *)getBoldColor;

- (NSColor *)getLinkBackgroundColor;
- (NSColor *)getLinkForegroundColor;
@end
