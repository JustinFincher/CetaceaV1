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

@property (nonatomic,strong) NSString *markdownString;
@property (nonatomic,strong) NSAttributedString *highLightString;
@property (nonatomic,strong) NSString *title;


- (BOOL)isEqualToDocument:(JZiCloudFileExtensionCetaceaDocument *)doc;


- (id)initWithURL:(NSURL *)url;
@property (nonatomic,strong) NSURL *urlWhenInited;


@end
