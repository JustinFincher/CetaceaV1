//
//  JZGlobalHeader.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/4/30.
//
//

#ifndef JZGlobalHeader_h
#define JZGlobalHeader_h

#import <Foundation/Foundation.h>

#ifdef DEBUG
#   define JZLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define JZLog(...)
#endif

#endif /* JZGlobalHeader_h */
