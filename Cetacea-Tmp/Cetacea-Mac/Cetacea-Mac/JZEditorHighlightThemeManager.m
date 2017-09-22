//
//  JZEditorHighlightThemeManager.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/14.
//  Copyright © 2016年 JustZht. All rights reserved.
//
#import "JZEditorHighlightThemeManager.h"
#import "JZiCloudFileExtensionCetaceaThemeDataBase.h"

@implementation JZEditorHighlightThemeManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static JZEditorHighlightThemeManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        [self refreshSelectedTheme];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)refreshSelectedTheme
{
    NSString *userDefaultDocPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedEditorHighlightTheme"];
    
    if (userDefaultDocPath)
    {
        JZiCloudFileExtensionCetaceaThemeDoc *doc = [[JZiCloudFileExtensionCetaceaThemeDoc alloc] initWithDocPath:userDefaultDocPath];
        if (doc && doc.data)
        {
            self.selectedDoc = doc;
        }else
        {
            JZiCloudFileExtensionCetaceaThemeDoc *doc = [[[JZiCloudFileExtensionCetaceaThemeDataBase sharedManager] loadDocs] objectAtIndex:0];
            if (doc)
            {
                
                self.selectedDoc = doc;
            }else
            {
                //        NSAssert(NO, @"selectedDoc should not be nil");
                self.selectedDoc = [[JZiCloudFileExtensionCetaceaThemeDoc alloc] initWithDocPath:[[JZiCloudFileExtensionCetaceaThemeDataBase sharedManager] nextDocPath]];
                JZLog(@" NSAssert(NO, selectedDoc should not be nil);");
            }
        }
    }else
    {
        NSMutableArray *docs = [[JZiCloudFileExtensionCetaceaThemeDataBase sharedManager] loadDocs];
        if (docs.count > 0) {
            JZiCloudFileExtensionCetaceaThemeDoc *doc = [docs objectAtIndex:0];
            self.selectedDoc = doc;
        } else {
            //        NSAssert(NO, @"selectedDoc should not be nil");
            self.selectedDoc = [[JZiCloudFileExtensionCetaceaThemeDoc alloc] initWithDocPath:[[JZiCloudFileExtensionCetaceaThemeDataBase sharedManager] nextDocPath]];
        }
    }
}
#pragma mark - Getter / Setter
- (void)setSelectedDoc:(JZiCloudFileExtensionCetaceaThemeDoc *)selectedDoc
{
    _selectedDoc = selectedDoc;
    [[NSUserDefaults standardUserDefaults] setObject:_selectedDoc.docPath forKey:@"selectedEditorHighlightTheme"];
}
@end
