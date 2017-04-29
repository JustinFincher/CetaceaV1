//
//  JZiCloudFileExtensionCetaceaThemeDoc.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudFileExtensionCetaceaThemeDoc.h"
#import "JZEditorLayouManager.h"
#import "JZEditorTextView.h"
#import "JZEditorMarkdownTextParserWithTSBaseParser.h"
#import "JZHeader.h"
#import <QuartzCore/QuartzCore.h>
#import "JZEditorHighlightThemeManager.h"

@implementation JZiCloudFileExtensionCetaceaThemeDoc


- (instancetype)initWithDocPath:(NSString *)docPath
{
    if ((self = [super init]))
    {
        self.docPath = docPath;
        //just init a data instance
        [self getData];
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
        JZLog(@"Error creating data path: %@", [error localizedDescription]);
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
    
    NSOperationQueue *saveQuene = [[NSOperationQueue alloc] init];
    [saveQuene addOperationWithBlock:^{
        
        // Background work
        //    _data.previewJPG = [self getPreviewImage];
        NSString *dataPath = [self.docPath stringByAppendingPathComponent:@"data.plist"];
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:_data forKey:@"Data"];
        [archiver finishEncoding];
        [data writeToFile:dataPath atomically:YES];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // Main thread work (UI usually)
        }];
    }];
}
- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:self.docPath error:&error];
    if (!success)
    {
        JZLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}
- (NSImage *)getPreviewImage
{
    JZEditorTextView *pageView = [[JZEditorTextView alloc] initWithFrame:NSMakeRect(0, 0, 200,160)];
    [[pageView textContainer] setWidthTracksTextView:YES];

    pageView.string = @"# About Cetacea\nCetacea is a `markdown editor` **designed** *to* ~~make~~ writing things simple, with various themes and multi-platform sync.";
    pageView.parser = [[JZEditorMarkdownTextParserWithTSBaseParser alloc] init];
    pageView.parser.themeDoc = self;

    [pageView.parser refreshAttributesTheme];
    [pageView.textStorage setAttributedString: [pageView.parser attributedStringFromMarkdown:pageView.string]];

    [pageView setupTextView];
    float scale = 2;
    float width = scale * pageView.bounds.size.width;
    float height = scale * pageView.bounds.size.height;
    
    NSRect targetRect = NSMakeRect(0.0, 0.0, width, height);
    NSBitmapImageRep *bitmapRep;
    
    bitmapRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil
                                                        pixelsWide:targetRect.size.width
                                                        pixelsHigh:targetRect.size.height
                                                     bitsPerSample:8
                                                   samplesPerPixel:4
                                                          hasAlpha:YES
                                                          isPlanar:NO
                                                    colorSpaceName:NSCalibratedRGBColorSpace
                                                      bitmapFormat:0
                                                       bytesPerRow:(4 * targetRect.size.width)
                                                      bitsPerPixel:32];
    
    [NSGraphicsContext saveGraphicsState];
    
    NSGraphicsContext *graphicsContext = [NSGraphicsContext graphicsContextWithBitmapImageRep:bitmapRep];
    [NSGraphicsContext setCurrentContext:graphicsContext];
    CGContextScaleCTM(graphicsContext.graphicsPort, scale, scale);

    [pageView displayRectIgnoringOpacity:pageView.bounds inContext:graphicsContext];
    
    [NSGraphicsContext restoreGraphicsState];
    
    NSImage *image = [[NSImage alloc] initWithSize:bitmapRep.size];
    
    [image addRepresentation:bitmapRep];

    return image;

}

- (BOOL)isEqualToDoc:(JZiCloudFileExtensionCetaceaThemeDoc *)object
{
    return ([self.docPath isEqualToString:object.docPath]);
}
- (BOOL)isSelectedDoc
{
    return [self isEqualToDoc:[[JZEditorHighlightThemeManager sharedManager] selectedDoc]];
}

@end
