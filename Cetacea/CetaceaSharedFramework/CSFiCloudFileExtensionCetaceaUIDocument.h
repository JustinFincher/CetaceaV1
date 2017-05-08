//
//  JZiCloudFileExtensionCetaceaUIDocument.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/8.
//
//

#import <UIKit/UIKit.h>
#import "CSFiCloudFileExtensionCetaceaSharedDocument.h"

@interface CSFiCloudFileExtensionCetaceaUIDocument : UIDocument

@property (weak) CSFiCloudFileExtensionCetaceaSharedDocument *sharedDocument;

- (id)initWithFileURL:(NSURL *)url withSharedDocument:(CSFiCloudFileExtensionCetaceaSharedDocument *)doc;
@end
