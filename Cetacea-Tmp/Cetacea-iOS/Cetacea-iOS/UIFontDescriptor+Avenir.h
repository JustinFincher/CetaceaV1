#import <UIKit/UIKit.h>

extern NSString *const ARUIFontTextStyleCaption3;
extern NSString *const ARUIFontTextStyleCaption4;

@interface UIFontDescriptor (Avenir)

+(UIFontDescriptor *)preferredAvenirFontDescriptorWithTextStyle:(NSString *)style;
+(UIFontDescriptor *)preferredAvenirBoldFontDescriptorWithTextStyle:(NSString *)style;

@end
