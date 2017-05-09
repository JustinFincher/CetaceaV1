//
//  JZGlobalHeader.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/4/30.
//
//

#ifndef CSFGlobalHeader_h
#define CSFGlobalHeader_h

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS || TARGET_OS_OSX
#import <DateTools/DateTools.h>
#endif

#ifdef DEBUG
#   define JZLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define JZLog(...)
#endif

#define CSF_String_Identifer_Developer_Team_ID @"UYK8GY9WS7"
#define CSF_String_Identifer_iCloud_Container_Name @"UYK8GY9WS7.iCloud.com.JustZht.Cetacea"
#define CSF_String_Notification_iCloud_Not_Availiable_Name @"CSF_String_Notification_iCloud_Not_Availiable_Name"

#define CSF_Block_Post_Notification_With_No_Object(x) [[NSNotificationCenter defaultCenter] postNotificationName:x object:nil];
#define CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(s,n,o) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(s) name:n object:o];

#endif /* CSFGlobalHeader_h */
