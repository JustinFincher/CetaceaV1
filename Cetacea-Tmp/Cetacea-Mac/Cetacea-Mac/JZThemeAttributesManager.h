//
//  JZThemeAttributesManager.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZiCloudFileExtensionCetaceaThemeDoc.h"

@interface JZThemeAttributesManager : NSObject

@property (nonatomic, strong) NSDictionary<NSString *, id> *headerAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *imageAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *linkAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *monospaceAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *strongAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *emphasisAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *lineBlockAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *codeBlockAttributes;

- (JZiCloudFileExtensionCetaceaThemeDoc *)currentTheme;


@end
