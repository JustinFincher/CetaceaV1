//
//  JZMarkdownListViewController.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/30.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZiCloudFileExtensionCetaceaDocument.h"

@protocol JZMarkdownListViewDelegate;

@interface JZMarkdownListViewController : NSViewController

@property (nonatomic, assign) id <JZMarkdownListViewDelegate> delegate;

@end

@protocol JZMarkdownListViewDelegate <NSObject>
@optional

- (void)rowSelected:(JZiCloudFileExtensionCetaceaDocument *)markdown;

@end
