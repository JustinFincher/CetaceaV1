//
//  CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import "CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel.h"

@implementation CSFCetaceaThemeSyntaxMarkupModel

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (!self) {
		return nil;
	}
	self.textFrontColor = [aDecoder decodeObjectForKey:@"textFrontColor"];
	self.textBackgroundColor = [aDecoder decodeObjectForKey:@"textBackgroundColor"];
	self.markupFrontColor = [aDecoder decodeObjectForKey:@"markupFrontColor"];
	self.markupBackgroundColor = [aDecoder decodeObjectForKey:@"markupBackgroundColor"];
	return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.textFrontColor forKey:@"textFrontColor"];
	[aCoder encodeObject:self.textBackgroundColor forKey:@"textBackgroundColor"];
	[aCoder encodeObject:self.markupFrontColor forKey:@"markupFrontColor"];
	[aCoder encodeObject:self.markupBackgroundColor forKey:@"markupBackgroundColor"];
}


@end

@implementation CSFCetaceaThemeSyntaxPresentationModel

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (!self) {
		return nil;
	}
	self.dayMarkup = [aDecoder decodeObjectForKey:@"dayMarkup"];
	self.nightMarkup = [aDecoder decodeObjectForKey:@"nightMarkup"];
	return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.dayMarkup forKey:@"dayMarkup"];
	[aCoder encodeObject:self.nightMarkup forKey:@"nightMarkup"];
}


@end
