//
//  JZiCloudStorageManager.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/30.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JZiCloudStorageManagerDelegate;

@interface JZiCloudStorageManager : NSObject

+ (id)sharedManager;

- (NSURL *)ubiquitousURL;

@property (nonatomic, assign) id <JZiCloudStorageManagerDelegate> delegate;

@end


@protocol JZiCloudStorageManagerDelegate <NSObject>
@optional

- (void)iCloudFileUpdated:(NSMetadataQuery *)query;

@end
