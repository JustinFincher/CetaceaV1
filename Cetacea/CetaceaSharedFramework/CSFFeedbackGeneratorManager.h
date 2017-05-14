//
//  CSFFeedbackGeneratorManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define CSFFont UIFont
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define CSFFont NSFont
#endif

@interface CSFFeedbackGeneratorManager : NSObject

+ (id)sharedManager;
#if TARGET_OS_IOS
@property (nonatomic,strong) UISelectionFeedbackGenerator* selectionFeedbackGenerator;
@property (nonatomic,strong) UIImpactFeedbackGenerator *impactFeedbackGenerator;
@property (nonatomic,strong) UINotificationFeedbackGenerator *notificationFeedbackGenerator;
#elif TARGET_OS_OSX

#endif

@end
