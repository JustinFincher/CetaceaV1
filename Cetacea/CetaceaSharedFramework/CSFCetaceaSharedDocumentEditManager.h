//
//  CSFCetaceaSharedDocumentEditManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/9.
//
//

#import <Foundation/Foundation.h>
#import "CSFiCloudFileExtensionCetaceaDataBase.h"
#import "CSFCetaceaAbstractSharedDocument.h"


/**
 An Edit Manager For Cetacea Files
 */
@interface CSFCetaceaSharedDocumentEditManager : NSObject

#pragma mark - Singleton Method
/**
 Singleton for this class

 @return instance
 */
+ (id)sharedManager;


/**
 Current editing cetacea file [CSFCetaceaAbstractSharedDocument](CSFCetaceaAbstractSharedDocument.html) instance
 */
@property (nonatomic,strong) CSFCetaceaAbstractSharedDocument * currentEditingDocument;
- (void)setCurrentEditingDocument:(CSFCetaceaAbstractSharedDocument *)doc;
- (BOOL)hasCurrentEditingDocument;

@end
