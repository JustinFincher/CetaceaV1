//
//  CSFConstants.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/16.
//
//

#import <Foundation/Foundation.h>

@interface CSFConstants : NSObject

#pragma mark - CSF.String.Identifer.Developer
/**
 CSF.String.Identifer.Developer
 Developer TeamID
 */
extern NSString *const CSFStringIdentiferDeveloperTeamID;
/// CSF.String.Identifer.Developer
/// iCloud Container Name
extern NSString *const CSFStringIdentiferiCloudContainerName;
extern NSString *const CSFStringIdentiferApplicationBundleID;
extern NSString *const CSFStringIdentiferAppGroupName;

#pragma mark - CSF.String.Identifer.UserDefault
/// CSF.String.Identifer.UserDefault
/// Saved Editor Base Font Name
extern NSString * const CSFStringIdentiferUserDefaultEditorBaseFontName;
/// CSF.String.Identifer.UserDefault
/// Saved Editor Base Font Size
extern NSString * const CSFStringIdentiferUserDefaultEditorBaseFontSize;

#pragma mark - CSF.String.Identifer.ActivityType
extern NSString * const CSFStringIdentiferActivityTypeEditingDocument;

#pragma mark - CSF.String.Notification
extern NSString * const CSFStringNotificationiCloudNotAvailiableName;
extern NSString * const CSFStringNotificationCurrentDocumentChangedName;

@end
