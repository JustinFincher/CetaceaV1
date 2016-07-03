//
//  JZdayNightThemeManager.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZdayNightThemeManager.h"
#import "DateTools.h"

@interface JZdayNightThemeManager()

@property (nonatomic,strong) NSTimer *checkSunMovementTimer;

@end

@implementation JZdayNightThemeManager
@synthesize checkSunMovementTimer;
#pragma mark Singleton Methods

+ (id)sharedManager {
    static JZdayNightThemeManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(darkModeChanged:) name:@"AppleInterfaceThemeChangedNotification" object:nil];
        checkSunMovementTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(checkSunMovementTimerFired) userInfo:nil repeats:YES];
    }
    return self;
}
- (void)checkSunMovementTimerFired
{
    if ([[[NSUserDefaults standardUserDefaults]
         stringForKey:@"dayNightThemeSwithType"] isEqualToString: @"JZDayNightThemeSwithTypeFollowTime"])
    {
        //NSLog(@"checkSunMovementTimerFired");
        [self postThemeChanged:[self getShouldAppliedNSAppearanceName]];
    }
}
-(void)darkModeChanged:(NSNotification *)notif
{
    if ([[[NSUserDefaults standardUserDefaults]
         stringForKey:@"dayNightThemeSwithType"] isEqualToString:@"JZDayNightThemeSwithTypeFollowSystem"])
    {
        [self postThemeChanged:[self getShouldAppliedNSAppearanceName]];
    }
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)setDayNightThemeSwithType:(JZDayNightThemeSwithType)type
{
    NSString *valueToSave = [self stringWithJZDayNightThemeSwithType:type];
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"dayNightThemeSwithType"];
    if ([[NSUserDefaults standardUserDefaults] synchronize])
    {
        [self postThemeChanged:[self getShouldAppliedNSAppearanceName]];

    };
}
- (NSUInteger)getLocalStoredJZDayNightThemeSwithTypeIndex
{
    NSString *dayNightThemeSwithType = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"dayNightThemeSwithType"];
    if ([dayNightThemeSwithType isEqualToString:@"JZDayNightThemeSwithTypeLight"])
    {
        return 0;
    }else if ([dayNightThemeSwithType isEqualToString:@"JZDayNightThemeSwithTypeDark"])
    {
        return 1;
    }else if ([dayNightThemeSwithType isEqualToString:@"JZDayNightThemeSwithTypeFollowSystem"])
    {
        return 2;
    }else if ([dayNightThemeSwithType isEqualToString:@"JZDayNightThemeSwithTypeFollowTime"])
    {
        return 3;
    }else
    {
        NSAssert(NO, @"dayNightThemeSwithType from NSUserDefaults not one of any validate theme.");
        return 0;
    }
}
- (void)postThemeChanged:(NSString *)NSAppearanceName
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"dayNightThemeSwitched" object:self userInfo:@{@"NSAppearanceName":NSAppearanceName}];
}
- (NSString *)stringWithJZDayNightThemeSwithType:(JZDayNightThemeSwithType)input
{
    NSArray *arr = @[
                     @"JZDayNightThemeSwithTypeLight",
                     @"JZDayNightThemeSwithTypeDark",
                     @"JZDayNightThemeSwithTypeFollowSystem",
                     @"JZDayNightThemeSwithTypeFollowTime"
                     ];
    return (NSString *)[arr objectAtIndex:input];
}
- (NSString *)getShouldAppliedNSAppearanceName
{
    NSString *dayNightThemeSwithType = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"dayNightThemeSwithType"];
    if ([dayNightThemeSwithType isEqualToString:@"JZDayNightThemeSwithTypeLight"])
    {
        return @"NSAppearanceNameVibrantLight";
    }else if ([dayNightThemeSwithType isEqualToString:@"JZDayNightThemeSwithTypeDark"])
    {
        return @"NSAppearanceNameVibrantDark";
    }else if ([dayNightThemeSwithType isEqualToString:@"JZDayNightThemeSwithTypeFollowSystem"])
    {
        NSString *osxMode = [[NSUserDefaults standardUserDefaults] stringForKey:@"AppleInterfaceStyle"];
        if ([osxMode isEqualToString:@"Dark"])
        {
            return @"NSAppearanceNameVibrantDark";
        }else
        {
            return @"NSAppearanceNameVibrantLight";
        }
    }else if ([dayNightThemeSwithType isEqualToString:@"JZDayNightThemeSwithTypeFollowTime"])
    {
        NSDate *now = [NSDate date];
        NSDate *sunrise = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"sunriseTime"];
        NSDate *sunset = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"sunsetTime"];
        
        BOOL isInside;
        if ([now hour] <= [sunset hour] && [now hour] >= [sunrise hour])
        {
            if ([now hour] == [sunset hour])
            {
                if ([now minute] <= [sunset minute])
                {
                    isInside = YES;
                }else
                {
                    isInside = NO;
                }
            }else if ([now hour] == [sunrise hour])
            {
                if ([now minute] >= [sunset minute])
                {
                    isInside = YES;
                }else
                {
                    isInside = NO;
                }
            }
            else
            {
                isInside = YES;
            }
        }else
        {
            isInside = NO;
        }
        
        if (isInside)
        {
            return @"NSAppearanceNameVibrantLight";
        }else
        {
            return @"NSAppearanceNameVibrantDark";
        }
    }else
    {
        return nil;
    }
}
- (void)setSunsetTime:(NSDate *)date
{
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"sunsetTime"];
    if ([[NSUserDefaults standardUserDefaults] synchronize])
    {
        [self postThemeChanged:[self getShouldAppliedNSAppearanceName]];
    };
}
- (void)setSunriseTime:(NSDate *)date
{
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"sunriseTime"];
    if ([[NSUserDefaults standardUserDefaults] synchronize])
    {
        [self postThemeChanged:[self getShouldAppliedNSAppearanceName]];
    };
}
- (NSDate *)getSunsetTime
{
    NSDate *sunset = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"sunsetTime"];
    return sunset;
}
- (NSDate *)getSunriseTime
{
    NSDate *sunrise = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"sunriseTime"];
    return sunrise;
}
@end
