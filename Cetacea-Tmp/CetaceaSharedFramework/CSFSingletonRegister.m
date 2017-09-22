//
//  JZSingletonRegister.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/11.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "CSFSingletonRegister.h"
@interface CSFSingletonRegister()

@property (nonatomic,strong) NSMutableDictionary *singletonDict;

@end

@implementation CSFSingletonRegister
#pragma mark Singleton Methods

+ (id)sharedManager {
    static CSFSingletonRegister *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        self.singletonDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc
{
    
}
- (void)unRegisterSingleton:(id)instance
{
    [self.singletonDict removeObjectForKey:NSStringFromClass([instance class])];
}
- (void)registerSingleton:(id)instance
{
    [self.singletonDict setObject:instance forKey:NSStringFromClass([instance class])];
}
- (id)getRegisteredSingletonForClassName:(NSString *)className
{
    return [self.singletonDict objectForKey:className];
}

@end
