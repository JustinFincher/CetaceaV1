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

+ (id)sharedManager;

- (NSFont *)getFont;
- (void)setFont:(NSFont *)font;

- (NSColor *)getTextColor;
- (NSColor *)getHeaderColor;
- (NSColor *)getBoldColor;

@end
