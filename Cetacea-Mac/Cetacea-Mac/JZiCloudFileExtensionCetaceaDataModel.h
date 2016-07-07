//
//  JZiCloudFileExtensionCetaceaDataModel.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/7.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZiCloudFileExtensionCetaceaDataModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *markdownString;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSAttributedString *highLightString;
@property (nonatomic,strong) NSMutableArray *tags;
@property (nonatomic,strong) NSNumber *isFavorite;
@property (nonatomic,strong) NSDate *createDate;
@property (nonatomic,strong) NSDate *updateDate;

@end
