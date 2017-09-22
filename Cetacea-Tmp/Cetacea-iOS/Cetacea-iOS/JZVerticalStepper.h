//===[ Required Headers ]================================================

// Cocoa
#import <UIKit/UIKit.h>
#import <CetaceaSharedFramework/CetaceaSharedFramework.h>


//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//---------------|  JZVerticalStepper class implementation  |--------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------

@interface JZVerticalStepper : UIControl

// Properties
@property (readwrite, nonatomic) float      minValue;           // Minimum stepper value
@property (readwrite, nonatomic) float      maxValue;           // Maximum stepper value
@property (readwrite, nonatomic) float      stepValue;          // Step up/down value
@property (readwrite, nonatomic) float      value;              // Currently displayed value
@property (readwrite, nonatomic) float      repeatDelaySec;     // Delay before auto-repeat, in seconds
@property (readwrite, nonatomic) float      repeatRate;         // Number of updates per second for auto-repeat
@property (readwrite, nonatomic) BOOL       wraps;              // YES = value wraps from max to minimum & minimum to maximum.
@property (readwrite, nonatomic) NSString   *formatString;      // String for formatting display
@property (readwrite, nonatomic) UIFont     *font;              // Font for label
@property (readwrite, nonatomic) UIColor    *textColor;         // Color of text
@property (readwrite, nonatomic) UIColor    *borderColor;       // Color of border
@property (readwrite, nonatomic) UIColor    *backgroundColor;   // Color of background

// Supported initializers
- (id)initWithFrame:(CGRect)a_frame;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end

