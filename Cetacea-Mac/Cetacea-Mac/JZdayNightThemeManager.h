//
//  JZdayNightThemeManager.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, JZDayNightThemeSwithType)
{
    JZDayNightThemeSwithTypeLight     = 0,
    JZDayNightThemeSwithTypeDark,
    JZDayNightThemeSwithTypeFollowSystem,
    JZDayNightThemeSwithTypeFollowTime
};

@interface JZdayNightThemeManager : NSObject
/**
 *  Singthon Method
 *
 *  @return Singthon
 */
+ (id)sharedManager;

/**
 *  Get should appied NSAppearanceName like `NSAppearanceNameVibrantDark` or `NSAppearanceNameVibrantLight` based on current Theme Swith Settings
 *
 *  @return a NSAppearanceName (Light / Dark)
 */
- (NSString *)getShouldAppliedNSAppearanceName;

/**
 *  Set the theme switch type, currently Four type to choose,
 @"JZDayNightThemeSwithTypeLight",
 @"JZDayNightThemeSwithTypeDark",
 @"JZDayNightThemeSwithTypeFollowSystem",
 @"JZDayNightThemeSwithTypeFollowTime"
 *
 *  @param type a JZDayNightThemeSwithType
 */
- (void)setDayNightThemeSwithType:(JZDayNightThemeSwithType)type;
- (NSString *)stringWithJZDayNightThemeSwithType:(JZDayNightThemeSwithType)input;
- (NSUInteger)getLocalStoredJZDayNightThemeSwithTypeIndex;
@end
