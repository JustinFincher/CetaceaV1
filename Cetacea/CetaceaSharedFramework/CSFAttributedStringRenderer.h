//
//  CSFAttributedStringRenderer.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/19.
//
//

#import <Foundation/Foundation.h>

@class CMDocument;
@class CSFTextAttributes;
@protocol CMHTMLElementTransformer;


/**
 The CSF AttributedString Renderer (this Renderer doesn't delete syntax markup)
 */
@interface CSFAttributedStringRenderer : NSObject


/**
 Init Method for Renderer

 @param document CMDocument for pull string source
 @param attributes TextAttributes Storage
 @return A Renderer Instance
 */
- (instancetype)initWithDocument:(CMDocument *)document attributes:(CSFTextAttributes *)attributes;
/**
 Render the current document to attributedString

 @return NSAttributedString
 */
- (NSAttributedString *)render;

@end
