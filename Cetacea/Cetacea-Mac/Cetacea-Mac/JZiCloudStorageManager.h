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
@property (nonatomic,strong) NSMetadataQuery *metadataQuery;

- (NSURL *)ubiquitousURL;
- (NSURL *)ubiquitousDocumentsURL;
- (NSURL *)ubiquitousDocumentsCetaceaURL;
- (NSURL *)ubiquitousDocumentsHighlightThemesURL;

@property (nonatomic, assign) id <JZiCloudStorageManagerDelegate> delegate;

@end


@protocol JZiCloudStorageManagerDelegate <NSObject>
@optional

/**
 *  iCloud Drive Query updated delegate
 *
 *  @param query give you a query of searched NSMetadataItems
 */
- (void)iCloudFileUpdated:(NSMetadataQuery *)query;

@end
