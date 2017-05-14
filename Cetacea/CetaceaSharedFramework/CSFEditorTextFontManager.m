//
//  CSFEditorTextFontManager.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/14.
//
//

#import "CSFEditorTextFontManager.h"
#import "CSFGlobalHeader.h"

@interface CSFEditorTextFontManager()

@property (nonatomic,strong) NSNumber *editorBaseFontSize;


@end

@implementation CSFEditorTextFontManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static CSFEditorTextFontManager *sharedMyManager = nil;
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

- (CGFloat)getFontSize
{
    NSNumber *editorBasefontSizeNum = [CSF_Block_UserDefault_With_SuiteName objectForKey:CSF_String_Identifer_UserDefault_Editor_BaseFont_Size];
    if (editorBasefontSizeNum == nil)
    {
        self.editorBaseFontSize = [NSNumber numberWithFloat:12.0f];
    }else
    {
        self.editorBaseFontSize = editorBasefontSizeNum;
    }
    return [editorBasefontSizeNum floatValue];
}
@end
