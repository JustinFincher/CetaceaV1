//
//  CSF.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/4/30.
//
//
#import <Foundation/Foundation.h>

//! Project version number for CetaceaSharedFramework
FOUNDATION_EXPORT double CetaceaSharedFrameworkVersionNumber;

//! Project version string for CetaceaSharedFramework
FOUNDATION_EXPORT const unsigned char CetaceaSharedFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <CetaceaSharedFramework/PublicHeader.h>
#import <CetaceaSharedFramework/CSFConstants.h>
#import <CetaceaSharedFramework/CSFGlobalHeader.h>
#import <CetaceaSharedFramework/CSFInitialProcessManager.h>
#import <CetaceaSharedFramework/CSFiCloudSyncManager.h>
#import <CetaceaSharedFramework/CSFiCloudFileExtensionCetaceaDataBase.h>
#import <CetaceaSharedFramework/CSFCetaceaSharedDocument.h>
#import <CetaceaSharedFramework/CSFCetaceaSharedDocumentEditManager.h>
#import <CetaceaSharedFramework/CSFDeviceCapabilityManager.h>
#import <CetaceaSharedFramework/CSFCetaceaSharedDocumentEditManager.h>
#import <CetaceaSharedFramework/CSFSingletonRegister.h>
#import <CetaceaSharedFramework/CSFEditorTextView.h>
#import <CetaceaSharedFramework/CSFEditorTextLayoutManager.h>
#import <CetaceaSharedFramework/CSFEditorTextRulerView.h>
#import <CetaceaSharedFramework/CSFEditorTextFontManager.h>
#import <CetaceaSharedFramework/CSFFeedbackGeneratorManager.h>
#import <CetaceaSharedFramework/CSFColorStorage.h>

#if TARGET_OS_IOS
#import <CetaceaSharedFramework/TSBaseParser.h>
#elif TARGET_OS_OSX
#endif
