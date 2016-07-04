//
//  JZiCloudFileSystemItem.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/5.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZiCloudStorageManager.h"

@interface JZiCloudFileSystemItem : NSObject

@property (nonatomic,strong) NSString *relativePath;
@property (nonatomic,weak) JZiCloudFileSystemItem *parent;
@property (nonatomic,strong) NSMutableArray *children;

+ (JZiCloudFileSystemItem *)rootItem;
- (NSInteger)numberOfChildren;// Returns -1 for leaf nodes
- (JZiCloudFileSystemItem *)childAtIndex:(NSUInteger)n; // Invalid to call on leaf nodes
- (NSString *)fullPath;
- (NSString *)relativePath;
- (void)refresh;

@end
