//
//  JZiCloudMarkdownFileModel.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZiCloudMarkdownFileModel : NSObject

@property (nonatomic) BOOL isUploaded;
@property (nonatomic) BOOL isUploading;
@property (nonatomic) BOOL isDownloaded;
@property (nonatomic) BOOL isDownloading;
@property (nonatomic) BOOL isUpToDate;
@property (nonatomic,strong) NSNumber * percentDownloaded;
@property (nonatomic,strong) NSNumber * percentUploaded;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSMetadataItem *metaDataItem;
@property (nonatomic,strong) NSString *previewString;
@property (nonatomic,strong) NSDate *creationDate;
@property (nonatomic,strong) NSDate *updatedDate;

@end
