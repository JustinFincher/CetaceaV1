//
//  JZiCloudStorageManager.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/30.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JZiCloudStorageManagerDelegate <NSObject>
@optional

- (void)iCloudFileUpdated:(NSMetadataQuery *)query;

@end


@interface JZiCloudStorageManager : NSObject

+ (id)sharedManager;

- (NSURL *)ubiquitousURL;

@property (nonatomic, weak) id <JZiCloudStorageManagerDelegate> delegate;

@end
