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

@implementation CSFEditorTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupTextView
{
#if TARGET_OS_IOS
    self.layoutManager.allowsNonContiguousLayout = YES;
#elif TARGET_OS_OSX
    self.wantsLayer = YES;
    self.automaticDashSubstitutionEnabled = NO;
    self.allowsDocumentBackgroundColorChange = YES;
    self.layoutManager.allowsNonContiguousLayout = YES;
#endif
}

#if TARGET_OS_IOS

#elif TARGET_OS_OSX
- (BOOL)isFlipped
{
    return YES;
}
#endif

@end
