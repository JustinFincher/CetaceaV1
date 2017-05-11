//
//  CSFCetaceaSharedDocumentEditManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/9.
//
//

#import <Foundation/Foundation.h>
#import "CSFiCloudFileExtensionCetaceaDataBase.h"
#import "CSFiCloudFileExtensionCetaceaSharedDocument.h"

@interface CSFCetaceaSharedDocumentEditManager : NSObject

+ (id)sharedManager;

@property (nonatomic,strong) CSFiCloudFileExtensionCetaceaSharedDocument * currentEditingDocument;
- (void)setCurrentEditingDocument:(CSFiCloudFileExtensionCetaceaSharedDocument *)doc;
- (BOOL)hasCurrentEditingDocument;

@end
