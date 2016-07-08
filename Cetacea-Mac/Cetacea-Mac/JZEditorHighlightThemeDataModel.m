//
//  JZEditorHighlightThemeDataModel.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorHighlightThemeDataModel.h"

@implementation JZEditorHighlightThemeDataModel
@synthesize themeName,previewJPG;
- (id)initWithDefault
{
    self=  [super init];
    if (self)
    {
        self.themeName = @"Untitled";
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self.themeName = [decoder decodeObjectForKey:@"themeName"];
        self.previewJPG = [decoder decodeObjectForKey:@"previewJPG"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:themeName forKey:@"themeName"];
    [encoder encodeObject:previewJPG forKey:@"previewJPG"];
}
@end
