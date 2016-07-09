//
//  JZColor.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZColorDataModel.h"

@implementation JZColorDataModel

- (id)init
{
    self = [super init];
    return self;
}
- (id)initWithColor:(JZColor *)color
{
    self = [super init];
    if (self)
    {
        JZColor *rgbColor = [color colorUsingColorSpaceName:@"NSCalibratedRGBColorSpace"];
        self.red = rgbColor.redComponent;
        self.green = rgbColor.greenComponent;
        self.blue = rgbColor.blueComponent;
        self.alpha = rgbColor.alphaComponent;
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.red = [decoder decodeFloatForKey:@"red"];
        self.green = [decoder decodeFloatForKey:@"green"];
        self.blue = [decoder decodeFloatForKey:@"blue"];
        self.alpha = [decoder decodeFloatForKey:@"alpha"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeFloat:self.red forKey:@"red"];
    [encoder encodeFloat:self.green forKey:@"green"];
    [encoder encodeFloat:self.blue forKey:@"blue"];
    [encoder encodeFloat:self.alpha forKey:@"alpha"];
}

- (JZColor *)colorFromSelf
{
    JZColor *color = [JZColor colorWithRed:self.red green:self.green blue:self.blue alpha:self.alpha];
    return color;
}

@end
