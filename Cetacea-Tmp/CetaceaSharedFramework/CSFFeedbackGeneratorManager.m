//
//  CSFFeedbackGeneratorManager.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import "CSFFeedbackGeneratorManager.h"

@implementation CSFFeedbackGeneratorManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static CSFFeedbackGeneratorManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
#if TARGET_OS_IOS
        self.selectionFeedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
        [self.selectionFeedbackGenerator prepare];
        self.impactFeedbackGenerator = [[UIImpactFeedbackGenerator alloc] init];
        [self.impactFeedbackGenerator prepare];
        self.notificationFeedbackGenerator = [[UINotificationFeedbackGenerator alloc] init];
        [self.notificationFeedbackGenerator prepare];
#elif TARGET_OS_OSX
        
#endif

    }
    return self;
}

@end
