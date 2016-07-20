//
//  JZColor.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#define JZColor UIColor
#else
#import <Cocoa/Cocoa.h>
#define JZColor NSColor
#endif

@interface JZColorDataModel : NSObject<NSCoding>

@property (nonatomic) float red;
@property (nonatomic) float green;
@property (nonatomic) float blue;
@property (nonatomic) float alpha;

/**
 *  Init With Given Color
 *
 *  @param color JZColor (NSColor / UIColor), the Given Color
 *
 *  @return instance
 */
- (id)initWithColor:(JZColor *)color;

/**
 *  Get NSColor / UIColor from JZColorDataModel
 *
 *  @return JZColor (NSColor / UIColor)
 */
- (JZColor *)colorFromSelf;

/**
 *  Update self JZColor
 *
 *  @param color color to replace
 */
- (void)setSelfColor:(JZColor *)color;
@end
