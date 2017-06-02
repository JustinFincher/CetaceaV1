//
//  CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
#import "CSFColorStorage.h"
#import "CSFGlobalHeader.h"
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#endif

/**
 Cetacea Theme, Single Syntax Markup Color Model
 */
@interface CSFCetaceaThemeSyntaxMarkupModel : NSObject<NSCoding>

/**
 Text Front Color
 */
@property (nonatomic,strong) CSFColorStorage *textFrontColor;

/**
 Text Background Color
 */
@property (nonatomic,strong) CSFColorStorage *textBackgroundColor;

/**
 Markup Front Color
 */
@property (nonatomic,strong) CSFColorStorage *markupFrontColor;

/**
 Markup Background Color
 */
@property (nonatomic,strong) CSFColorStorage *markupBackgroundColor;

@end


/**
 Cetacea Theme, Single Syntax Markup Color Model For Both Day/Night Presentation
 */
@interface CSFCetaceaThemeSyntaxPresentationModel : NSObject<NSCoding>


/**
 Markup Model For The Day
 */
@property (nonatomic,strong) CSFCetaceaThemeSyntaxMarkupModel *dayMarkup;

/**
 Markup Model For The Night
 */
@property (nonatomic,strong) CSFCetaceaThemeSyntaxMarkupModel *nightMarkup;

@end
