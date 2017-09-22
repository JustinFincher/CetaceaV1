//===[ Required Headers ]================================================

// Cocoa
#import <QuartzCore/QuartzCore.h>

// Our stuff
#import "JZVerticalStepper.h"


//===[ Local Items ]=====================================================

// Macros
#define CORNER_RADIUS  6.0f


//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//----------------|  JZVerticalStepper class implementation  |-------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------

//===[ Class extension for private-ish items ]===========================
#pragma mark - Private class extension
@interface JZVerticalStepper ()
{
    float           _flAutoStepValue;   // Hold-to-repeat step value (dynamic)
    int             _iUpdateCount;      // # of auto-repeat adjustments
    NSTimer         *_repeatTimer;      // Hold-to-repeat timer
    UIButton        *_btnUp,            // Value increment button
    *_btnDown;          // Value decrement button
    UIImage         *_imgUp,            // Up arrow image
    *_imgDown;          // Down arrow image
    UILabel         *_lblValue;         // Value label
}


@end


//===[ Public Items ]====================================================
@implementation JZVerticalStepper

#pragma mark - View lifecycle
//-----------------------------------------------------------------------
//  Method: initWithFrame:
//      Initialize the view to be the size specified by the passed
//      rectangle.
//
- (id)initWithFrame:(CGRect)a_frame
{
    // Pass up the inheritance chain first
    self = [super initWithFrame:a_frame];
    
    // Did that work?
    if (self) {
        // Assign default values
        [self initChildViews];
        [self setDefaults];
    }
    
    // Done!
    return self;
}


//------------------------------------------------------------------------
// Method:  initWithCoder:
//  Initializes the instance when brought from nib, etc.
//
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        // Assign default values
        [self initChildViews];
        [self setDefaults];
    }
    
    // Done!
    return self;
}


#pragma mark - Accessors
//-----------------------------------------------------------------------
//  Method: setEnabled:
//      Enables/disables the control as specified.
//
- (void) setEnabled:(BOOL)a_fEnabled
{
    // Call parent first
    [super setEnabled:a_fEnabled];
    
    // Enable/disable our items
    _btnDown.enabled = a_fEnabled;
    _btnUp.enabled = a_fEnabled;
}


//-----------------------------------------------------------------------
//  Method: setMinValue:
//      Sets minimum allowable value for stepper.   If current value
//      is less than the new minimum value, it will be set to the
//      new minimum.
//
- (void) setMinValue:(float)a_flValue
{
    // Save it and set the current value
    // ... Setting the current value clamps to new limits
    _minValue = a_flValue;
    [self setValue:_value];
}


//-----------------------------------------------------------------------
//  Method: setMaxValue:
//      Sets maximum allowable value for stepper.   If current value
//      is greater than the new maximum value, it will be set to the
//      new maximum.
//
- (void) setMaxValue:(float)a_flValue
{
    // Save it and set the current value
    // ... Setting the current value clamps to new limits
    _maxValue = a_flValue;
    [self setValue:_value];
}


//-----------------------------------------------------------------------
//  Method: setValue:
//      Sets value and updates display accordingly
//
- (void) setValue:(float)a_value
{
    // Clamp the value to min/max and update display
    _value = MIN(_maxValue, MAX(_minValue, a_value));
    [self updateDisplay];
}


//-----------------------------------------------------------------------
//  Method: setFormatString:
//      Sets new format string and updates display to match.
//
- (void) setFormatString:(NSString *)a_str
{
    // Save it
    _formatString = a_str;
    [self updateDisplay];
}


//-----------------------------------------------------------------------
//  Method: setFont:
//      Sets font for label
//
- (void) setFont:(UIFont *)a_font
{
    // Save it
    _lblValue.font = a_font;
}


//-----------------------------------------------------------------------
//  Method: setTextColor:
//      Sets color of text on stepper control
//
- (void) setTextColor:(UIColor *)a_color
{
    // Do it
    _lblValue.textColor = a_color;
}


//-----------------------------------------------------------------------
//  Method: setBackgroundColor:
//      Sets background color for control
//
- (void) setBackgroundColor:(UIColor *)a_color
{
    // Pass it up...
    [super setBackgroundColor:a_color];
}


#pragma mark - View Layout & Drawing
//-----------------------------------------------------------------------
//  Method: layoutSubViews
//      This method arranges the views which comprise the control.
//
- (void)layoutSubviews
{
    // Call parent before going about our business...
    [super layoutSubviews];
    
    // Size the buttons
    CGRect rctButton = self.bounds; // CGRectInset(self.bounds, -CORNER_RADIUS, 0.0f);
    rctButton.size.height = (rctButton.size.height / 2.0f);
    _btnUp.frame = rctButton;
    
    // Position the 'down' button below the 'up' button
    rctButton.origin.y = rctButton.origin.y + rctButton.size.height + 1.0f;
    _btnDown.frame = rctButton;
    
    // Center the label over the control
    CGRect rctLabel = self.bounds;
    rctLabel.origin.x += 8.0f;
    rctLabel.size.width -= 8.0f;
    _lblValue.frame = rctLabel;
    
    // Adjust image insets for buttons
    _btnUp.imageEdgeInsets = UIEdgeInsetsMake(_btnUp.bounds.size.height - _imgUp.size.height - 2.0f,
                                              _btnUp.bounds.size.width * 0.7f,
                                              0.0f,
                                              0.0f);
    _btnDown.imageEdgeInsets = UIEdgeInsetsMake(0.0f,
                                                _btnDown.bounds.size.width * 0.7f,
                                                _btnDown.bounds.size.height - _imgUp.size.height - 2.0f,
                                                0.0f);
}


//-----------------------------------------------------------------------
//  Method: drawRect:
//      Performs custom drawing of the view when the specified
//      rectangle needs to be redrawn.
- (void)drawRect:(CGRect)rect
{
    CGContextRef        ctx;                // Drawing context
    
    // Get stuff needed for drawing
    ctx = UIGraphicsGetCurrentContext();
    
    // Draw line through the middle
    CGContextSetStrokeColorWithColor(ctx, _borderColor.CGColor);
    CGContextSetLineWidth(ctx, 0.5f);
    float flHalfHeight = self.bounds.size.height / 2.0f;
    CGContextMoveToPoint(ctx, 0.0f, flHalfHeight);
    CGContextAddLineToPoint(ctx, self.bounds.size.width, flHalfHeight);
    
    // Stroke the path out
    CGContextStrokePath(ctx);
    
    // triagnels
    int sides = 3;
    CGContextSetFillColorWithColor(ctx, self.borderColor.CGColor);
    double size = rect.size.height / 6.0;
    CGPoint center = CGPointMake(rect.size.width - size * 1.5f , rect.size.height / 4.0);
    double radius = size / 2.0;
    double theta = 2.0 * M_PI / sides;
    CGContextMoveToPoint(ctx, center.x, center.y-radius);
    for (NSUInteger k=1; k<sides; k++) {
        float x = radius * sin(k * theta);
        float y = radius * cos(k * theta);
        CGContextAddLineToPoint(ctx, center.x+x, center.y-y);
    }
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    center = CGPointMake(rect.size.width - size * 1.5f , rect.size.height / 4.0 * 3.0);
    CGContextMoveToPoint(ctx, center.x, center.y+radius);
    for (NSUInteger k=1; k<sides; k++)
    {
        float x = radius * sin(k * theta + M_PI);
        float y = radius * cos(k * theta + M_PI);
        CGContextAddLineToPoint(ctx, center.x+x, center.y-y);
    }
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}



//===[ Unpublished Items ]===============================================

#pragma mark - Initialization helpers
//-----------------------------------------------------------------------
//  Method: initChildViews
//      Creates the child views that comprise the stepper control.
//      This includes increment & decrement buttons as well as
//      a label to contain the present value.
//
- (void) initChildViews
{
    // Configure the 'up' button
    _btnUp = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnUp.backgroundColor = [UIColor clearColor];
    [_btnUp addTarget:self action:@selector(didStartIncrement:) forControlEvents:UIControlEventTouchDown];
    [_btnUp addTarget:self action:@selector(didEndValueChange:) forControlEvents:UIControlEventTouchUpInside];
    [_btnUp addTarget:self action:@selector(didEndValueChange:) forControlEvents:UIControlEventTouchUpOutside];
    [self addSubview:_btnUp];
    
    // Configure the 'down' button
    _btnDown = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDown.backgroundColor = [UIColor clearColor];
    [_btnDown addTarget:self action:@selector(didStartDecrement:) forControlEvents:UIControlEventTouchDown];
    [_btnDown addTarget:self action:@selector(didEndValueChange:) forControlEvents:UIControlEventTouchUpInside];
    [_btnDown addTarget:self action:@selector(didEndValueChange:) forControlEvents:UIControlEventTouchUpOutside];
    [self addSubview:_btnDown];
    
    // Create the label
    _lblValue = [[UILabel alloc] init];
    _lblValue.backgroundColor = [UIColor clearColor];
    _lblValue.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lblValue];
}


//-----------------------------------------------------------------------
//  Method: setDefaults
//      Set instance defaults
//
-(void) setDefaults
{
    // Set values, etc.
    _minValue = 5.0f;
    _maxValue = 80.0f;
    _stepValue = 1.0f;
    _value = _minValue;
    _repeatDelaySec = 0.3f;
    _repeatRate = 15.0f;
    _wraps = NO;
    _formatString = @"%0.1f";
    _backgroundColor = [UIColor whiteColor];
    _borderColor = [UIColor lightGrayColor];
    
    // Configure our view
    self.layer.cornerRadius = CORNER_RADIUS;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = _borderColor.CGColor;
    self.font = [UIFont systemFontOfSize:22.0f];
    
    // Update the display
    [self updateDisplay];
}


#pragma mark - Timer event handlers
//-----------------------------------------------------------------------
//  Method: startAutoRepeat:
//      Called when the repeat delay timer fires.   Used to start
//      the auto-repeat timer.
//
- (void) repeatDelayTimerFired:(NSTimer *)a_timer
{
    // Kill the delay timer and start repeat timer
    [_repeatTimer invalidate];
    _repeatTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0f/_repeatRate)
                                                    target:self
                                                  selector:@selector(autoRepeatTimerFired:)
                                                  userInfo:nil
                                                   repeats:YES];
}


//-----------------------------------------------------------------------
//  Method: autoRepeatTimerFired:
//      Called when the "hold-to-repeat" timer fires.  Adjusts
//      the value as appropriate.
//
- (void) autoRepeatTimerFired:(NSTimer *) a_timer
{
    // Is wrapping enabled?
    if( _wraps ) {
        // Yes, will we need to wrap this time?
        if( _value + _flAutoStepValue > _maxValue ) {
            // Yes: maximum exceeded - wrap to minimum
            [self setValue:_minValue];
        }
        else if(_value + _flAutoStepValue < _minValue) {
            // Yes: minimum exceeded - wrap to maximum
            [self setValue:_maxValue];
        }
        else {
            // No, business as usual
            [self setValue:_value + _flAutoStepValue];
        }
    }
    else {
        // Not wrapping - update the value and display
        [self setValue:_value + _flAutoStepValue];
    }
    
    // Send the UIControl event
    // ... This lets us play nice with IB
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    [[[CSFFeedbackGeneratorManager sharedManager] selectionFeedbackGenerator] selectionChanged];
    
    // Update counters
    ++_iUpdateCount;
    switch( _iUpdateCount ) {
        case 10:     // After one second, update at 2x speed
            _flAutoStepValue *= 2.0f;
            break;
            
        case 20:    // After two seconds, update at 5x speed
            _flAutoStepValue *= 2.5f;
            break;
            
        case 30:    // After three seconds, update at 10x speed
            _flAutoStepValue *= 2.0f;
            break;
            
        default:    // ...otherwise do nothing
            ;
    }
}


#pragma mark - Value update methods
//-----------------------------------------------------------------------
//  Method: didStartIncrement:
//      Called when the "up" button is tapped.   Increments value by
//      step amount, and starts update timer to enable "hold-to-repeat"
//      functionality.
//
-(void) didStartIncrement:(id)sender
{
    // Adjust the value and display it
    // ... The property will clamp it to the allowable range and
    // ... also update the display.
    if( _wraps && (_value + _stepValue > _maxValue) ) {
        // Wrapping is enabled and minimum value has been
        // ... been exceeded.   New value is maximum limit.
        self.value = _minValue;
    }
    else {
        // Update normally
        self.value = _value + _stepValue;
    }
    
    // Start the timer?
    if( _repeatRate > 0.0f && _repeatDelaySec > 0.0f )
    {
        if (_repeatTimer)
        {
            [_repeatTimer invalidate];
        }else
        {            // Do it!
            _iUpdateCount = 1;
            _flAutoStepValue = _stepValue;
            _repeatTimer = [NSTimer scheduledTimerWithTimeInterval:_repeatDelaySec
                                                            target:self
                                                          selector:@selector(repeatDelayTimerFired:)
                                                          userInfo:nil
                                                           repeats:NO];
        }
    }
    
    // Publish start editing event
    [self sendActionsForControlEvents:UIControlEventEditingDidBegin];
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    [[[CSFFeedbackGeneratorManager sharedManager] selectionFeedbackGenerator] selectionChanged];
}


//-----------------------------------------------------------------------
//  Method: didStartDecrement:
//      Called when the "down" button is tapped.   Decrements value
//      by step amount and starts update timer for "hold-to-repeat"
//      functionality.
//
-(void) didStartDecrement:(id)sender
{
    // Adjust the value and display it
    // ... The property will clamp it to the allowable range and
    // ... also update the display.
    if( _wraps && (_value - _stepValue < _minValue) ) {
        // Wrapping is enabled and minimum value has been
        // ... been exceeded.   New value is maximum limit.
        self.value = _maxValue;
    }
    else {
        // Update normally
        self.value = _value - _stepValue;
    }
    
    // Start the timer?
    if( _repeatRate > 0.0f && _repeatDelaySec > 0.0f ) {
        _iUpdateCount = 1;
        _flAutoStepValue = -(_stepValue);
        _repeatTimer = [NSTimer scheduledTimerWithTimeInterval:_repeatDelaySec
                                                        target:self
                                                      selector:@selector(repeatDelayTimerFired:)
                                                      userInfo:nil
                                                       repeats:NO];
    }
    
    // Publish start editing event
    [self sendActionsForControlEvents:UIControlEventEditingDidBegin];
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    [[[CSFFeedbackGeneratorManager sharedManager] selectionFeedbackGenerator] selectionChanged];
}


//-----------------------------------------------------------------------
//  Method: didEndValueChange:
//      Called when the "hold-to-repeat" update is done.
//
- (void) didEndValueChange:(id)sender
{
    // Kill the timer
    [_repeatTimer invalidate];
    _repeatTimer = nil;
    
    
    // Send action events
    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [[[CSFFeedbackGeneratorManager sharedManager] selectionFeedbackGenerator] selectionChanged];
}


//-----------------------------------------------------------------------
//  Method: updateDisplay
//      Update the displayed value
//
-(void) updateDisplay
{
    NSString *string = [NSString stringWithFormat:_formatString, _value];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSString *formatString = [array lastObject];
    NSString *valueString = @"";
    for (int i = 0; i < array.count - 1; i++)
    {
        valueString = [valueString stringByAppendingString:[array objectAtIndex:i]];
    }
    UIFont *sizeFont = [UIFont fontWithName:@"FiraCode-Bold" size:42.0f];
    NSDictionary *sizeFontDict = [NSDictionary dictionaryWithObject: sizeFont forKey:NSFontAttributeName];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:valueString attributes: sizeFontDict];
    
    UIFont *formatFont = [UIFont fontWithName:@"FiraCode-Bold" size:13.0f];
    NSDictionary *formatFontDict = [NSDictionary dictionaryWithObject:formatFont forKey:NSFontAttributeName];
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:formatString attributes:formatFontDict];
    [attributedString appendAttributedString:vAttrString];
    
    _lblValue.attributedText = attributedString;
    
    // Update buttons
    _btnUp.enabled = (_wraps || (_value < _maxValue));
    _btnDown.enabled = (_wraps || (_value > _minValue));
}


@end
