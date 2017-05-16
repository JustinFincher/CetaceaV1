//
//  CSFColorStorage.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/16.
//
//

#import <Foundation/Foundation.h>
#import "CSFGlobalHeader.h"


/**
 A RGBA Properties based presentation of CSFColor (UIColor/NSColor)
 */
@interface CSFColorStorage : NSObject<NSCoding>


/**
 Set Color Storage with a plaform specific Color Class (UIColor/NScolor) instance
 @param color Color To Set
 */
- (void)setColor:(CSFColor *)color;
- (CSFColor *)getColor;

/**
 Red
 @note read only, to set this value, use [setColor](#/c:objc(cs)CSFColorStorage(im)setColor:)
 */
@property (nonatomic) NSNumber *r;

/**
 Green
 @note read only, to set this value, use [setColor](#/c:objc(cs)CSFColorStorage(im)setColor:)
 */
@property (nonatomic) NSNumber *g;

/**
 Blue
 @note read only, to set this value, use [setColor](#/c:objc(cs)CSFColorStorage(im)setColor:)
 */
@property (nonatomic) NSNumber *b;

/**
 Alpha
 @note read only, to set this value, use [setColor](#/c:objc(cs)CSFColorStorage(im)setColor:)
 */
@property (nonatomic) NSNumber *a;

@end
