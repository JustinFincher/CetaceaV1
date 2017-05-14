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

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#define CSFColor UIColor
#define CSFRect CGRect

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define CSF_Device_Capability_Force_Touch_Enabled [[CSFDeviceCapabilityManager sharedManager] isForceTouchAvailable]
#define CSF_String_Notification_Navigation_Resize_Item_Pressed_Name @"CSF_String_Notification_Navigation_Resize_Item_Pressed_Name"
#define CSF_String_Notification_Set_Current_Editing_Document_Null_Name @"CSF_String_Notification_Set_Current_Editing_Document_Null_Name"

#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#define CSFColor NSColor
#define CSFRect NSRect

#endif

#ifdef DEBUG
#   define JZLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define JZLog(...)
#endif


#define CSF_String_Identifer_Developer_Team_ID @"UYK8GY9WS7"
#define CSF_String_Identifer_iCloud_Container_Name @"UYK8GY9WS7.iCloud.com.JustZht.Cetacea"
#define CSF_String_Identifer_Application_Bundle_ID @"com.JustZht.Cetacea"
#define CSF_String_Identifer_App_Group_Name @"group.com.JustZht.Cetacea"

#define CSF_String_Identifer_UserDefault_Editor_BaseFont_Size @"com.JustZht.Cetacea.UserDefault.Editor.BaseFont.Size"
#define CSF_String_Identifer_ActivityType_Editing_Document @"com.JustZht.Cetacea.ActivityType.EditingDocument"

#define CSF_String_Notification_iCloud_Not_Availiable_Name @"CSF_String_Notification_iCloud_Not_Availiable_Name"
#define CSF_String_Notification_Current_Document_Changed_Name @"CSF_String_Notification_Current_Document_Changed_Name"
#define CSF_Block_Post_Notification_With_Name_Object_UserInfo(n,o,u) [[NSNotificationCenter defaultCenter] postNotificationName:n object:o userInfo:u]
#define CSF_Block_Post_Notification_With_Name_No_Object(n) [[NSNotificationCenter defaultCenter] postNotificationName:n object:nil];
#define CSF_Block_Post_Notification_With_Name_Object(n,o) [[NSNotificationCenter defaultCenter] postNotificationName:n object:o];
#define CSF_Block_Add_Notification_Observer_With_Selector_Name_Object(s,n,o) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(s) name:n object:o];
#define CSF_Block_Add_Notification_Observer_With_Name_Object_Block(n,o,b) [[NSNotificationCenter defaultCenter] addObserverForName:n object:o queue:[NSOperationQueue mainQueue] usingBlock:b];
#define CSF_Block_UserDefault_With_SuiteName [[NSUserDefaults alloc] initWithSuiteName:CSF_String_Identifer_Application_Bundle_ID]

#define CSF_Block_Main_Storyboard_VC_From_Identifier(x) [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:x]
#define CSF_Block_Main_Storyboard_VC_From_Class(x) [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:NSStringFromClass(x)]


#endif /* CSFGlobalHeader_h */
