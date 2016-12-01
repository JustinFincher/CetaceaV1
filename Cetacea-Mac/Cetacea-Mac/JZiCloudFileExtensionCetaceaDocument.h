//
//  JZiCloudFileExtensionCetaceaDocument.h
//  Cetacea
//
//  Created by Justin Fincher on 2016/12/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JZiCloudFileExtensionCetaceaDocument : NSDocument

@property (nonatomic,strong) NSFileWrapper * documentFileWrapper;

/**
 *  Markdown String
 */
@property (nonatomic,strong) NSString *markdownString;
/**
 *  Cached Highlight NSAttributedString
 */
@property (nonatomic,strong) NSAttributedString *highLightString;

/**
 *  Title
 */
@property (nonatomic,strong) NSString *title;

- (BOOL)isEqualToDocument:(JZiCloudFileExtensionCetaceaDocument *)doc;


@end
