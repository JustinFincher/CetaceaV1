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

#pragma mark Font Helpers
- (NSArray *)getAllFontInApp
{
    NSMutableArray *fonts = [NSMutableArray array];
    for (NSString* family in [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [[UIFont fontNamesForFamilyName:family] sortedArrayUsingSelector:@selector(compare:)])
        {
            NSLog(@"  %@", name);
            [fonts addObject:name];
        }
    }
    return fonts;
}
- (NSArray *)getCanBeSelectedFontInApp
{
	[self getAllFontInApp];
	return [NSArray arrayWithObjects:@"AmericanTypewriter",@"AmericanTypewriter-Condensed",@"Avenir-Book",@"AvenirNext-Medium",@"AvenirNextCondensed-Regular",@"Courier-Bold",@"CourierNewPSMT",@"FiraCode-Retina",@"FiraCode-Bold",@"Futura-Medium",@"Helvetica",@"HelveticaNeue-CondensedBold",@"Menlo-Regular",@"Monoid-Retina", nil];
}
#pragma mark - Editor Base Font
- (NSString *)getEditorBaseFontFamilyName
{
    NSString *editorBasefontName = [CSF_Block_UserDefault_With_SuiteName objectForKey:CSFStringIdentiferUserDefaultEditorBaseFontName];
    if (editorBasefontName == nil)
    {
        editorBasefontName = [[CSFFont systemFontOfSize:12] fontName];
    }
    return editorBasefontName;
}
- (void)setEditorBaseFont:(CSFFont *)font
{
    [CSF_Block_UserDefault_With_SuiteName setObject:[font fontName] forKey:CSFStringIdentiferUserDefaultEditorBaseFontName];
    [CSF_Block_UserDefault_With_SuiteName setObject:[NSNumber numberWithFloat:[font pointSize]] forKey:CSFStringIdentiferUserDefaultEditorBaseFontSize];
}
- (CGFloat)getEditorBaseFontSize
{
    NSNumber *editorBasefontSizeNum = [CSF_Block_UserDefault_With_SuiteName objectForKey:CSFStringIdentiferUserDefaultEditorBaseFontSize];
    if (editorBasefontSizeNum == nil)
    {
        editorBasefontSizeNum = [NSNumber numberWithFloat:12.0f];
    }
    return [editorBasefontSizeNum floatValue];
}

- (CSFFont *)getEditorBaseFont
{
    CSFFont *font = [CSFFont fontWithName:[self getEditorBaseFontFamilyName] size:[self getEditorBaseFontSize]];
    if (font)
    {
        return font;
    }else
    {
        return [CSFFont systemFontOfSize:12.0f];
    }
}
- (CSFFont *)getEditorMonospacedFont
{
    return [CSFFont fontWithName:@"Fira Code" size:[self getEditorBaseFontSize]];
}
@end
