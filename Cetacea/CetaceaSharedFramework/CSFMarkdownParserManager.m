//
//  CSFMarkdownParserManager.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import "CSFMarkdownParserManager.h"

@implementation CSFMarkdownParserManager

#pragma mark Singleton Methods

+ (id)sharedManager {
	static CSFMarkdownParserManager *sharedMyManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedMyManager = [[self alloc] init];
	});
	return sharedMyManager;
}

- (id)init {
	if (self = [super init])
	{
		self.paragraphParser = [TSBaseParser new];
		self.fullParser = [TSBaseParser new];
		self.lineParser = [TSBaseParser new];
		self.shouldRemoveTags = NO;
		
		
		
	}
	return self;
}

- (void)dealloc
{
	
}


@end
