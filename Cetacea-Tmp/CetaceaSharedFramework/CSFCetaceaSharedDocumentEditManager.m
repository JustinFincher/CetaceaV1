//
//  CSFCetaceaSharedDocumentEditManager.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/9.
//
//

#import "CSFCetaceaSharedDocumentEditManager.h"
#import "CSFGlobalHeader.h"
@interface CSFCetaceaSharedDocumentEditManager()

@property (nonatomic,strong) NSUserActivity *currentUserActivity;

@end


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
- (void)setCurrentEditingDocument:(CSFCetaceaAbstractSharedDocument *)doc
{
    _currentEditingDocument = doc;
    if (_currentEditingDocument)
    {
        CSF_Block_Post_Notification_With_Name_Object_UserInfo(CSFStringNotificationCurrentDocumentChangedName, self, (@{ @"doc" : doc,
                                                                                                                               @"hasDoc" : @YES }));
        if (self.currentUserActivity)
        {
            [self.currentUserActivity invalidate];
        }
        self.currentUserActivity = [[NSUserActivity alloc] initWithActivityType:CSFStringIdentiferActivityTypeEditingDocument];
        self.currentUserActivity.title = @"Edit Document";
        self.currentUserActivity.expirationDate = [[NSDate date] dateByAddingDays:1];
        self.currentUserActivity.needsSave = YES;
        self.currentUserActivity.eligibleForSearch = YES;
        self.currentUserActivity.eligibleForHandoff = YES;
        [self.currentUserActivity addUserInfoEntriesFromDictionary:[NSDictionary dictionaryWithObject:doc.url forKey:@"doc.url"]];
        [self.currentUserActivity becomeCurrent];
    }else
    {
        CSF_Block_Post_Notification_With_Name_Object_UserInfo(CSFStringNotificationCurrentDocumentChangedName, self, (@{
                                                                                                                               @"hasDoc" : @NO }));
        if (self.currentUserActivity)
        {
            [self.currentUserActivity resignCurrent];
        }
    }
}
- (BOOL)hasCurrentEditingDocument
{
    return (self.currentEditingDocument != nil);
}

@end
