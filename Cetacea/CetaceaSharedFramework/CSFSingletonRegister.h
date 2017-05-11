//
//  JZSingletonRegister.h
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/11.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Instance For Storing all single stuff (ui, data manager, etc)
 */
@interface CSFSingletonRegister : NSObject
+ (id)sharedManager;

- (void)registerSingleton:(id)instance;
- (void)unRegisterSingleton:(id)instance;
- (id)getRegisteredSingletonForClassName:(NSString *)className;

@end
