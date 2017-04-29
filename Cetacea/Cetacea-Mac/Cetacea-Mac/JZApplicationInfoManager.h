//
//  JZApplicationInfoManager.h
//  Cetacea
//
//  Created by Justin Fincher on 2017/3/31.
//  Copyright © 2017年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZApplicationInfoManager : NSObject
+ (id)sharedManager;
- (NSString *)getAppVersion;
- (NSString *)getBuildNumber;
- (NSString *)getAppVersionInfoAndBuildNumber;
@end
