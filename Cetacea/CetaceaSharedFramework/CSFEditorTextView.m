//
//  CSFEditorTextView.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/12.
//
//

#import "CSFEditorTextView.h"
#import "CSFEditorTextContainer.h"
#import "CSFEditorTextLayoutManager.h"
#import "CSFEditorTextRulerView.h"
#import "CSFEditorTextStorage.h"
#import "CSFGlobalHeader.h"

@interface CSFEditorTextView()

@property (nonatomic,strong) NSAttributedString *attParagraphStrWithAllRange;
@property (nonatomic,strong) NSAttributedString *attLineStrWithinVisiableRange;
@property (nonatomic,strong) CSFEditorTextLayoutManager *csfTextLayoutManager;

@property (atomic) BOOL hasBeenSetup;

@end

@implementation CSFEditorTextView

- (instancetype)init
{
    if (self = [super init])
    {
        _hasBeenSetup = NO;
#if TARGET_OS_IOS
        [self setupTextView];
#elif TARGET_OS_OSX
#endif
    }
    return self;
}

- (void)setupTextView
{
    JZLog(@"setupTextView");
    self.csfTextLayoutManager = [[CSFEditorTextLayoutManager alloc] init];
    [self.textContainer replaceLayoutManager:self.csfTextLayoutManager];
    self.layoutManager.allowsNonContiguousLayout = YES;
#if TARGET_OS_IOS
    
    
#elif TARGET_OS_OSX
    self.wantsLayer = YES;
    self.automaticDashSubstitutionEnabled = NO;
    self.allowsDocumentBackgroundColorChange = YES;
#endif
    
    self.hasBeenSetup = YES;
}

#if TARGET_OS_IOS
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!_hasBeenSetup)
    {
        [self setupTextView];
    }
}
#elif TARGET_OS_OSX
- (BOOL)isFlipped
{
    return YES;
}
- (void)viewDidMoveToWindow
{
    if (!_hasBeenSetup)
    {
        [self setupTextView];
    }
}
#endif

- (void)setCurrentEditingDocument:(CSFiCloudFileExtensionCetaceaSharedDocument *)currentEditingDocument
{
    _currentEditingDocument = currentEditingDocument;
#if TARGET_OS_IOS
    [self setText:(currentEditingDocument == nil) ? @"" : currentEditingDocument.markdownString];
#elif TARGET_OS_OSX
    [self setString:(currentEditingDocument == nil) ? @"" : currentEditingDocument.markdownString];
#endif
    //    [self.editorTextView.parser refreshAttributesTheme];
    [self refreshHightLight];
}
- (void)refreshHightLight
{
    
}
@end
