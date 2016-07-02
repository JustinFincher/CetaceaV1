//
//  JZiCloudStorageProcesser.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JZiCloudStorageProcesserDelegate;

@interface JZiCloudStorageProcesser : NSObject

+ (id)sharedManager;

@property (nonatomic, assign) id <JZiCloudStorageProcesserDelegate> delegate;

@end


@protocol JZiCloudStorageProcesserDelegate <NSObject>
@optional

/**
 *  iCloud Files Processed Delegate
 *
 *  @param markdowns give you processed Markdowns Array contains of JZiCloudMarkdownFileModel
 */
- (void)iCloudFileProcessed:(NSMutableArray *)markdowns;

@end