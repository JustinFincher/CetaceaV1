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
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *defaultDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *atxHeaderDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *setextHeaderDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *codeBlockDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *tabIndentDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *boldDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *italicDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *strikeThroughDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *listDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *quoteDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *imageDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *linkDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *editorViewDataModel;
@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaThemeSyntaxMarkupModel *ruleViewDataModel;

@end
