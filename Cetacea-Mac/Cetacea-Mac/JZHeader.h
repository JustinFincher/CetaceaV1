//
//  JZHeader.h
//  Cetacea-Mac
//
//  Created by Justin Fincher on 2016/11/28.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#ifndef JZHeader_h
#define JZHeader_h

#ifdef DEBUG
#   define JZLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define JZLog(...)
#endif

#import "JZApplicationInfoManager.h"
#import "JZStaticValues.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <DateTools/DateTools.h>
#import "JZColorDataModel.h"
#import "DynamicColor-Swift.h"

#endif /* JZHeader_h */
