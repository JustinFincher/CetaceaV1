//
//  JZHeader.h
//  Cetacea-Mac
//
//  Created by Justin Fincher on 2016/11/28.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#ifndef JZHeader_h
#define JZHeader_h

//#ifdef DEBUG
//#define JZLog(s, ...) NSLog(s, ##__VA_ARGS__)
//#else
//#define JZLog(s, ...)
//#endif

#ifdef DEBUG
#   define JZLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define JZLog(...)
#endif

#endif /* JZHeader_h */
