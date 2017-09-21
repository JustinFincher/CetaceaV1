//
//  BOSetting.m
//  BOSettings
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOSetting+Private.h"
@implementation BOSetting

- (instancetype)initWithKey:(NSString *)key {
	if (key) {
		if (self = [super init]) {
			_key = key;
			[[NSOperationQueue mainQueue] addOperationWithBlock:^
			 {
				 [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:self.key options:NSKeyValueObservingOptionNew context:nil];
				 
				 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDefaultsDidChange:) name:NSUserDefaultsDidChangeNotification object:nil];
			 }];
		}
	}
	
	return self;
}

+ (instancetype)settingWithKey:(NSString *)key {
	return [[self alloc] initWithKey:key];
}
- (void)userDefaultsDidChange:(NSNotification *)notif
{
	[[NSOperationQueue mainQueue] addOperationWithBlock:^
	 {
		 if (self.valueDidChangeBlock) self.valueDidChangeBlock();
	 }];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	[[NSOperationQueue mainQueue] addOperationWithBlock:^
	 {
		 self.value = change[@"new"];
		 if (self.valueDidChangeBlock) self.valueDidChangeBlock();
	 }];
}

- (id)value
{
	return [[NSUserDefaults standardUserDefaults] objectForKey:self.key];
}

- (void)setValue:(id)value {
	if (self.value != value)
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock:^
		 {
			 [[NSUserDefaults standardUserDefaults] setObject:value forKey:self.key];
			 if (![[NSUserDefaults standardUserDefaults] synchronize])
			 {
				 NSLog(@"[[NSUserDefaults standardUserDefaults] synchronize] = NO");
			 }
		 }];
		if (self.valueDidChangeBlock)
		{
			self.valueDidChangeBlock();
		}
	}
//	[[NSOperationQueue mainQueue] addOperationWithBlock:^
//	 {
//		 [[NSUserDefaults standardUserDefaults] setObject:value forKey:self.key];
//		 if (![[NSUserDefaults standardUserDefaults] synchronize])
//		 {
//			 NSLog(@"[[NSUserDefaults standardUserDefaults] synchronize] = NO");
//		 }
//	 }];
}

- (void)setValueDidChangeBlock:(void (^)(void))valueDidChangeBlock {
	_valueDidChangeBlock = valueDidChangeBlock;
	if (valueDidChangeBlock) valueDidChangeBlock();
}

- (void)dealloc {
	if (self.key)
	{
		[[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:self.key];
		[[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
	}
}

@end
