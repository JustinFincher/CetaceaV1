//
//  JZiCloudFileExtensionCetaceaDoc.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/7.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudFileExtensionCetaceaDoc.h"
#import "JZHeader.h"

@implementation JZiCloudFileExtensionCetaceaDoc

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
        self.docPath = [[JZiCloudFileExtensionCetaceaDataBase sharedManager] nextDocPath];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:self.docPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success)
    {
        JZLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return success;
    
}
- (JZiCloudFileExtensionCetaceaDataModel *)getData
{
    return [self data];
}

- (JZiCloudFileExtensionCetaceaDataModel *)data {
    
    
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
        self.data = [[JZiCloudFileExtensionCetaceaDataModel alloc] init];
        self.data.createDate = [NSDate new];
        self.data.updateDate = [NSDate new];
        self.data.title = @"";
        self.data.markdownString = @"";
        self.data.highLightString = [[NSAttributedString alloc] initWithString:@""];
    }
    
    return _data;
    
}
- (void)saveData {
    
    if (_data == nil) return;
    
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
        JZLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}

- (NSImage *)loadImage:(NSString *)imageName
{
    NSString *fullImagePath = [_docPath stringByAppendingPathComponent:imageName];
    return [[NSImage alloc] initWithContentsOfFile:fullImagePath];
}
- (void)saveImage:(NSImage *)image
         withName:(NSString *)imageName
{
    if (!image || !imageName)
    {
        return;
    }
    [self createDataPath];
    NSString *imagePath = [_docPath stringByAppendingPathComponent:imageName];
    NSData *imageData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.6] forKey:NSImageCompressionFactor];
    if ([[imageName pathExtension]  isEqual: @"jpg"] || [[imageName pathExtension]  isEqual: @"jpeg"])
    {
        imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    }else
    {
        imageData = [imageRep representationUsingType:NSPNGFileType properties:imageProps];
    }
    [imageData writeToFile:imagePath atomically:YES];
}

- (BOOL)isEqualToDoc:(JZiCloudFileExtensionCetaceaDoc *)doc
{
    BOOL isEqual = [doc.docPath isEqualTo: self.docPath];
    return isEqual;
}
@end
