//
//  CSFAttributedStringRenderer.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/19.
//
//

#import <Foundation/Foundation.h>

@class CMDocument;
@class CMTextAttributes;
@protocol CMHTMLElementTransformer;

@interface CSFAttributedStringRenderer : NSObject

- (instancetype)initWithDocument:(CMDocument *)document attributes:(CMTextAttributes *)attributes;
- (NSAttributedString *)render;

@end
