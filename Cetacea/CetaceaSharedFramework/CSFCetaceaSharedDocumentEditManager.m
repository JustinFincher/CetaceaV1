//
//  CSFCetaceaSharedDocumentEditManager.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/9.
//
//

#import "CSFCetaceaSharedDocumentEditManager.h"
#import "CSFGlobalHeader.h"

@implementation CSFCetaceaSharedDocumentEditManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static CSFCetaceaSharedDocumentEditManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
    }
    return self;
}

- (void)dealloc
{
    
}
- (void)setCurrentEditingDocument:(CSFiCloudFileExtensionCetaceaSharedDocument *)doc
{
    _currentEditingDocument = doc;
    if (_currentEditingDocument)
    {
        CSF_Block_Post_Notification_With_Name_Object_UserInfo(CSF_String_Notification_Current_Document_Changed_Name, self, (@{ @"doc" : doc,
                                                                                                                               @"hasDoc" : @YES }));
        NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:CSF_String_Identifer_ActivityType_Editing_Document];
        userActivity.title = @"Edit Document";
        [userActivity addUserInfoEntriesFromDictionary:[NSDictionary dictionaryWithObject:doc forKey:@"doc"]];
        [userActivity becomeCurrent];
    }else
    {
        CSF_Block_Post_Notification_With_Name_Object_UserInfo(CSF_String_Notification_Current_Document_Changed_Name, self, (@{
                                                                                                                               @"hasDoc" : @NO }));
    }
}
- (BOOL)hasCurrentEditingDocument
{
    return (self.currentEditingDocument != nil);
}

@end
