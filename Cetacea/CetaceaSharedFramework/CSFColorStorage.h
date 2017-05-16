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

- (void)setColor:(CSFColor *)color;


/**
 Red
 */
@property (nonatomic) NSNumber *r;

/**
 Green
 */
@property (nonatomic) NSNumber *g;

/**
 Blue
 */
@property (nonatomic) NSNumber *b;

/**
 Alpha
 */
@property (nonatomic) NSNumber *a;

@end
