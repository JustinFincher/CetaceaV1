//
//  JZiCloudFileExtensionCetaceaDataModel.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/7.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudFileExtensionCetaceaDataModel.h"

@implementation JZiCloudFileExtensionCetaceaDataModel
@synthesize markdownString,highLightString,isFavorite,tags;
@synthesize createDate,updateDate,title;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.markdownString = [decoder decodeObjectForKey:@"markdownString"];
        self.highLightString = [decoder decodeObjectForKey:@"highLightString"];
        self.tags = [decoder decodeObjectForKey:@"tags"];
        self.isFavorite = [decoder decodeObjectForKey:@"isFavorite"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.createDate = [decoder decodeObjectForKey:@"createDate"];
        self.updateDate = [decoder decodeObjectForKey:@"updateDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:markdownString forKey:@"markdownString"];
    [encoder encodeObject:highLightString forKey:@"highLightString"];
    [encoder encodeObject:tags forKey:@"tags"];
    [encoder encodeObject:title forKey:@"title"];
    [encoder encodeObject:isFavorite forKey:@"isFavorite"];
    [encoder encodeObject:createDate forKey:@"createDate"];
    [encoder encodeObject:updateDate forKey:@"updateDate"];
}

@end
