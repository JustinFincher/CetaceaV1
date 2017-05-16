//
//  CSFColorStorage.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/16.
//
//

#import "CSFColorStorage.h"

@interface CSFColorStorage()

@property (nonatomic,strong) CSFColor *platformDependentColorInstance;

@end

@implementation CSFColorStorage

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.r = [aDecoder decodeObjectForKey:@"r"];
    self.g = [aDecoder decodeObjectForKey:@"g"];
    self.b = [aDecoder decodeObjectForKey:@"b"];
    self.a = [aDecoder decodeObjectForKey:@"a"];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.r forKey:@"r"];
    [aCoder encodeObject:self.g forKey:@"g"];
    [aCoder encodeObject:self.b forKey:@"b"];
    [aCoder encodeObject:self.a forKey:@"a"];
}

- (void)setColor:(CSFColor *)color
{
    _platformDependentColorInstance = color;
}

- (NSNumber *)r
{
    CGFloat rToGet = 0.0f;
    [self.platformDependentColorInstance getRed:&rToGet green:0 blue:0 alpha:0];
    return [NSNumber numberWithFloat:rToGet];
}
- (NSNumber *)g
{
    CGFloat gToGet = 0.0f;
    [self.platformDependentColorInstance getRed:0 green:&gToGet blue:0 alpha:0];
    return [NSNumber numberWithFloat:gToGet];
}
- (NSNumber *)b
{
    CGFloat bToGet = 0.0f;
    [self.platformDependentColorInstance getRed:0 green:0 blue:&bToGet alpha:0];
    return [NSNumber numberWithFloat:bToGet];
}
- (NSNumber *)a
{
    CGFloat aToGet = 0.0f;
    [self.platformDependentColorInstance getRed:0 green:0 blue:0 alpha:&aToGet];
    return [NSNumber numberWithFloat:aToGet];
}

@end
