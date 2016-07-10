//
//  JZEditorHighlightThemeSingleRowDataModel.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/9.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorHighlightThemeSingleRowDataModel.h"

@implementation JZEditorHighlightThemeSingleRowDataModel

- (id)initWithDefaultTextStyle
{
    if (self = [super init])
    {
        self.lightForegroundTagtColor = [[JZColorDataModel alloc] initWithColor:[NSColor blackColor]];
        self.lightForegroundTextColor = [[JZColorDataModel alloc] initWithColor:[NSColor darkGrayColor]];
        self.lightBackgroundBlockColor = [[JZColorDataModel alloc] initWithColor:[NSColor clearColor]];
        
        self.darkForegroundTagtColor = [[JZColorDataModel alloc] initWithColor:[NSColor whiteColor]];
        self.darkForegroundTextColor = [[JZColorDataModel alloc] initWithColor:[NSColor lightGrayColor]];
        self.darkBackgroundBlockColor = [[JZColorDataModel alloc] initWithColor:[NSColor clearColor]];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self.lightForegroundTagtColor = [decoder decodeObjectForKey:@"lightForegroundTagtColor"];
        self.lightForegroundTextColor = [decoder decodeObjectForKey:@"lightForegroundTextColor"];
        self.lightBackgroundBlockColor = [decoder decodeObjectForKey:@"lightBackgroundBlockColor"];
        
        self.darkForegroundTagtColor = [decoder decodeObjectForKey:@"darkForegroundTagtColor"];
        self.darkForegroundTextColor = [decoder decodeObjectForKey:@"darkForegroundTextColor"];
        self.darkBackgroundBlockColor = [decoder decodeObjectForKey:@"darkBackgroundBlockColor"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.lightForegroundTagtColor forKey:@"lightForegroundTagtColor"];
    [encoder encodeObject:self.lightForegroundTextColor forKey:@"lightForegroundTextColor"];
    [encoder encodeObject:self.lightBackgroundBlockColor forKey:@"lightBackgroundBlockColor"];
    
    [encoder encodeObject:self.darkForegroundTagtColor forKey:@"darkForegroundTagtColor"];
    [encoder encodeObject:self.darkForegroundTextColor forKey:@"darkForegroundTextColor"];
    [encoder encodeObject:self.darkBackgroundBlockColor forKey:@"darkBackgroundBlockColor"];
}



@end
