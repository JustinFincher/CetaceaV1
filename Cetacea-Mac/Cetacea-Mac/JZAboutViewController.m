//
//  JZAboutViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZAboutViewController.h"

@interface JZAboutViewController ()
@property (weak) IBOutlet NSTextField *cetaceaLabel;
@property (weak) IBOutlet NSImageView *backgroundImageView;
@property (weak) IBOutlet NSView *frontContainerView;

@property (nonatomic) NSPoint backgroundImageInitalLocation;
@property (nonatomic) NSPoint frontContainerViewInitalLocation;

@end

@implementation JZAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    _backgroundImageInitalLocation = _backgroundImageView.frame.origin;
    _frontContainerViewInitalLocation = _frontContainerView.frame.origin;
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 4;
    shadow.shadowOffset = NSMakeSize(0, 0);
    shadow.shadowColor = [NSColor colorWithWhite:0.0f alpha:0.6f];
    _cetaceaLabel.shadow = shadow;
    
    
    NSTrackingAreaOptions options = (NSTrackingActiveAlways | NSTrackingInVisibleRect |
                                     NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved);
    
    NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:[self.view bounds]
                                                        options:options
                                                          owner:self
                                                       userInfo:nil];
    [self.view addTrackingArea:area];
}

- (void)mouseMoved:(NSEvent *)event
{
    [super mouseMoved: event];
    NSPoint locationInView = [self.view convertPoint:[event locationInWindow]
                                       fromView:nil];
    //NSLog(@"%f,%f",locationInView.x,locationInView.y);
    NSPoint parallexEffectPoint = NSMakePoint((self.view.frame.size.width - locationInView.x), (self.view.frame.size.height - locationInView.y));
    
    [_backgroundImageView setFrameOrigin:CGPointMake(_backgroundImageInitalLocation.x + parallexEffectPoint.x/10, _backgroundImageInitalLocation.y + parallexEffectPoint.y/10)];
    
    [_frontContainerView setFrameOrigin:CGPointMake(_frontContainerViewInitalLocation.x - parallexEffectPoint.x/100, _frontContainerViewInitalLocation.y - parallexEffectPoint.y/100)];

}

@end
