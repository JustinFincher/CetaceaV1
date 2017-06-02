//
//  CSFiCloudFileExtensionCetaceaThemeSharedDocument.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
#import "CSFGlobalHeader.h"
#import "CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel.h"
#import "CSFSharedDocumentBase.h"

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define CSFCetaceaNativeSharedDocument CSFCetaceaThemeUIDocument
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define CSFCetaceaNativeSharedDocument CSFCetaceaThemeNSDocument
#endif

@class CSFCetaceaThemeAbstractSharedDocument;

@interface CSFCetaceaNativeSharedDocument : CSFNativeSharedDocument
#pragma mark - Override
- (CSFCetaceaThemeAbstractSharedDocument *)abstractDocument;
@end


@interface CSFCetaceaThemeAbstractSharedDocument : CSFAbstractSharedDocument
#pragma mark - Override
+ (CSFCetaceaThemeAbstractSharedDocument *)newDocument;
- (CSFCetaceaNativeSharedDocument *)nativeDocument;



#pragma mark - Property

/**
 Default Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *defaultDataModel;
@property (nonatomic,strong) NSDictionary<NSString *, id> *defaultTextAttributes;

/**
 Atx Header Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *atxHeaderDataModel;
@property (nonatomic,strong) NSDictionary<NSString *, id> *atxHeaderTextAttributes;
@property (nonatomic,strong) NSDictionary<NSString *, id> *atxHeaderTagAttributes;

/**
 Setext Header Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *setextHeaderDataModel;
@property (nonatomic,strong)NSDictionary<NSString *, id> *setextHeaderTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *setextHeaderTagAttributes;

/**
 Code Block Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *codeBlockDataModel;
@property (nonatomic,strong)NSDictionary<NSString *, id> *codeBlockTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *codeBlockTagAttributes;

/**
 Tab Indent Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *tabIndentDataModel;
@property (nonatomic,strong)NSDictionary<NSString *, id> *tabIndentTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *tabIndentTagAttributes;

/**
 Bold Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *boldDataModel;
@property (nonatomic,strong)NSDictionary<NSString *, id> *BoldTextAttributes;
@property (nonatomic,strong)NSDictionary<NSString *, id> *BoldTagAttributes;

/**
 Italic Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *italicDataModel;

/**
 Strike Through Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *strikeThroughDataModel;

/**
 List Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *listDataModel;

/**
 Quote Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *quoteDataModel;

/**
 Image Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *imageDataModel;

/**
 Link Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *linkDataModel;

/**
 Editor View Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *editorViewDataModel;

/**
 Ruler View Markup
 */
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *ruleViewDataModel;

@end
