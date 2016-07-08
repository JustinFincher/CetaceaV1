//
//  JZiCloudFileExtensionCetaceaThemeDoc.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudFileExtensionCetaceaThemeDoc.h"

@implementation JZiCloudFileExtensionCetaceaThemeDoc


- (instancetype)initWithDocPath:(NSString *)docPath
{
    if ((self = [super init]))
    {
        self.docPath = docPath;
    }
    return self;
}

- (BOOL)createDataPath {
    
    if (self.docPath == nil) {
        self.docPath = [[JZiCloudFileExtensionCetaceaThemeDataBase sharedManager] nextDocPath];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:self.docPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success)
    {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return success;
    
}
- (JZEditorHighlightThemeDataModel *)getData
{
    return [self data];
}

- (JZEditorHighlightThemeDataModel *)data {
    
    
    if (_data != nil) return _data;
    
    NSString *dataPath = [self.docPath stringByAppendingPathComponent:@"data.plist"];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:dataPath];
    if (codedData)
    {
        if (codedData == nil) return nil;
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
        _data = [unarchiver decodeObjectForKey:@"Data"];
        [unarchiver finishDecoding];
        
    }else
    {
        self.data = [[JZEditorHighlightThemeDataModel alloc] initWithDefault];
    }
    
    return _data;
    
}
- (void)saveData {
    
    if ([self getData] == nil) return;
    
    [self createDataPath];
    
    NSString *dataPath = [self.docPath stringByAppendingPathComponent:@"data.plist"];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_data forKey:@"Data"];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
    
}
- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:self.docPath error:&error];
    if (!success)
    {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}

@end
