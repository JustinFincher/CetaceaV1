//
//  FileProviderEnumerator.h
//  FileProviderExtension
//
//  Created by Fincher Justin on 9/6/17.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import <FileProvider/FileProvider.h>

@interface FileProviderEnumerator : NSObject <NSFileProviderEnumerator>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithEnumeratedItemIdentifier:(NSFileProviderItemIdentifier)enumeratedItemIdentifier;

@property (nonatomic, readonly, strong) NSFileProviderItemIdentifier enumeratedItemIdentifier;

@end
