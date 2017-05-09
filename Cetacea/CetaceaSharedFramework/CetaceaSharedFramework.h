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
#import <CetaceaSharedFramework/CSFGlobalHeader.h>
#import "SDVersion.h"
#import "DateTools.h"
#import <CetaceaSharedFramework/CSFInitialProcessManager.h>
#import <CetaceaSharedFramework/CSFiCloudSyncManager.h>
#import <CetaceaSharedFramework/CSFiCloudFileExtensionCetaceaDataBase.h>
#import <CetaceaSharedFramework/CSFiCloudFileExtensionCetaceaSharedDocument.h>

#if TARGET_OS_IOS
#import <CetaceaSharedFramework/CSFiCloudFileExtensionCetaceaUIDocument.h>
#elif TARGET_OS_OSX
#import <CetaceaSharedFramework/CSFiCloudFileExtensionCetaceaNSDocument.h>
#endif
