//
//  JZdayNightThemeManager.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Day / Night Theme Switch Method
 */
typedef NS_OPTIONS(NSUInteger, JZDayNightThemeSwithType) {
    /**
     *  Light Theme, using JZDayNightThemeSwithTypeLight
     */
    JZDayNightThemeSwithTypeLight     = 0,
    /**
     *  Dark Theme, using JZDayNightThemeSwithTypeDark
     */
    JZDayNightThemeSwithTypeDark,
    /**
     *  Switch Light Dark based on system ui theme
     */
    JZDayNightThemeSwithTypeFollowSystem,
    /**
     *  Switch Light Dark based on time
     */
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
 *  Post a Theme Changed Notifcation, you should use getShouldAppliedNSAppearanceName method to get the NSAppearanceName
 *
 *  @param NSAppearanceName NSAppearanceName to be applied
 */
- (void)postThemeChanged:(NSString *)NSAppearanceName;

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

/**
 *  Get the JZDayNightThemeSwithType string name from enum value
 *
 *  @param input a JZDayNightThemeSwithType enum value
 *
 *  @return the NSString from given enum value
 */
- (NSString *)stringWithJZDayNightThemeSwithType:(JZDayNightThemeSwithType)input;


/**
 *  Get User Default stored JZDayNightThemeSwithType enum value
 *
 *  @return the JZDayNightThemeSwithType enum value from User Default
 */
- (NSUInteger)getLocalStoredJZDayNightThemeSwithTypeIndex;

/**
 *  set Sun set NSDate for JZDayNightThemeSwithTypeFollowTime
 *
 *  @param date NSDate sun set time
 */
- (void)setSunsetTime:(NSDate *)date;

/**
 *  set Sun rise NSDate for JZDayNightThemeSwithTypeFollowTime
 *
 *  @param date NSDate sun rise time
 */
- (void)setSunriseTime:(NSDate *)date;

/**
 *  get Sun set Time
 *
 *  @return NSDate
 */
- (NSDate *)getSunsetTime;

/**
 *  get Sun rise Time
 *
 *  @return NSDate
 */
- (NSDate *)getSunriseTime;

- (BOOL)getEditPreviewPanelShouldUsingBlurredBackground;
- (void)setEditPreviewPanelShouldUsingBlurredBackground:(BOOL)should;
@end
