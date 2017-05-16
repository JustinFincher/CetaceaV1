//
//  CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
#import "CSFGlobalHeader.h"
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#endif

@interface CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel : NSObject

@property (nonatomic,strong) CSFColor *textFrontColor;
@property (nonatomic,strong) CSFColor *textBackgroundColor;
@property (nonatomic,strong) CSFColor *markupFrontColor;
@property (nonatomic,strong) CSFColor *markupBackgroundColor;

@end

@interface CSFiCloudFileExtensionCetaceaThemeSyntaxPresentationModel : NSObject

@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *dayMarkup;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *nightMarkup;

@end
