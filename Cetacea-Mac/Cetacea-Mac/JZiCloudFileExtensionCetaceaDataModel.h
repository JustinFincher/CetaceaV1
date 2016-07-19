//
//  JZiCloudFileExtensionCetaceaDataModel.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/7.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZiCloudFileExtensionCetaceaDataModel : NSObject<NSCoding>

/**
 *  Markdown String
 */
@property (nonatomic,strong) NSString *markdownString;

/**
 *  Title
 */
@property (nonatomic,strong) NSString *title;

/**
 *  Cached Highlight NSAttributedString
 */
@property (nonatomic,strong) NSAttributedString *highLightString;

/**
 *  Tags Array
 */
@property (nonatomic,strong) NSMutableArray *tags;
@property (nonatomic,strong) NSNumber *isFavorite;
@property (nonatomic,strong) NSDate *createDate;
@property (nonatomic,strong) NSDate *updateDate;

@end
