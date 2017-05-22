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

#import <CocoaMarkdown/CocoaMarkdown.h>
#import "CSFAttributedStringRenderer.h"

#if TARGET_OS_IOS
#define textViewDelegate UITextViewDelegate
#elif TARGET_OS_OSX
#define textViewDelegate NSTextViewDelegate
#endif


@interface CSFEditorTextView()<textViewDelegate>

@property (nonatomic,strong) NSAttributedString *generatedAttributedString;
@property (nonatomic,strong) CSFEditorTextLayoutManager *csfTextLayoutManager;

@property (atomic) BOOL hasBeenSetup;

@property (nonatomic,strong) CSFAttributedStringRenderer *renderer;
@property (nonatomic,strong) CMDocument *cmDocument;

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
	
	self.cmDocument = [[CMDocument alloc] initWithData:[[NSString stringWithFormat:@""] dataUsingEncoding:NSUTF8StringEncoding] options:0];
	self.renderer = [[CSFAttributedStringRenderer alloc] initWithDocument:self.cmDocument attributes:[[CMTextAttributes alloc] init]];
	
	self.delegate = self;
	
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

- (void)setCurrentEditingDocument:(CSFCetaceaAbstractSharedDocument *)currentEditingDocument
{
	_currentEditingDocument = currentEditingDocument;
	[self refreshFileContent];
	[self refreshHightLight];
	[self updateTextView];
}
- (void)refreshFileContent
{
	if (self.currentEditingDocument)
	{
		[self.cmDocument updateWithData:[self.currentEditingDocument.markdownString dataUsingEncoding:NSUTF8StringEncoding] options:0];
	}else
	{
		self.cmDocument = [[CMDocument alloc] initWithData:[[NSString stringWithFormat:@""] dataUsingEncoding:NSUTF8StringEncoding] options:0];
	}
}
- (void)refreshHightLight
{
#if TARGET_OS_IOS
	self.generatedAttributedString = [self.renderer render];
#elif TARGET_OS_OSX
	
#endif
	[self.renderer invalidate];
}
- (void)updateTextView
{
	BOOL isNotTypingPinyin = NO;
#if TARGET_OS_IOS
	isNotTypingPinyin = self.markedTextRange == nil;
#elif TARGET_OS_OSX
	isNotTypingPinyin = self.markedRange.length == 0;
#endif
	if (isNotTypingPinyin)
	{
		//不在输入拼音
		NSRange range = self.selectedRange;
		if (self.generatedAttributedString != nil)
		{
			[self.textStorage setAttributedString: self.generatedAttributedString];
			if ([self.generatedAttributedString.string length] >= range.location + range.length)
			{
				// [begin--range--end]--stringend
				[self setSelectedRange:range];
			}
			else if ([self.generatedAttributedString.string length] < range.location + range.length && [self.generatedAttributedString.string length] > range.location)
			{
				// [begin--range--stringend--end]
				[self setSelectedRange:NSMakeRange(range.location, 0)];
			}else
			{
				// stringend--[begin--range--end]
				[self setSelectedRange:NSMakeRange([self.generatedAttributedString.string length], 0)];
			}
		}
	}else
	{
		//正在输入拼音 不能替换
	}
}
- (NSRange)characterRangeFromVisibleRect
{
#if TARGET_OS_IOS
	CGRect bounds = self.bounds;
	UITextPosition *start = [self characterRangeAtPoint:bounds.origin].start;
	UITextPosition *end = [self characterRangeAtPoint:CGPointMake(CGRectGetMaxX(bounds), CGRectGetMaxY(bounds))].end;
	return NSMakeRange([self offsetFromPosition:self.beginningOfDocument toPosition:start],
        [self offsetFromPosition:start toPosition:end]);
#elif TARGET_OS_OSX
	NSRange glyphRange, charRange;
	NSLayoutManager *layoutManager = [self
									  layoutManager];
	NSTextContainer *textContainer = [self
									  textContainer];
	NSPoint containerOrigin = [self
							   textContainerOrigin];
	aRect = NSOffsetRect([self visibleRect], -containerOrigin.x,
						 -containerOrigin.y);
	
	glyphRange = [layoutManager
				  glyphRangeForBoundingRect:[self visibleRect]
				  inTextContainer:textContainer];
	charRange = [layoutManager
				 characterRangeForGlyphRange:glyphRange
				 actualGlyphRange:NULL];
	return charRange;
#endif
}

#pragma mark - TextViewDelegate
#if TARGET_OS_IOS
- (void)textViewDidChange:(UITextView *)textView
{
	[self onTextChange];
}
#elif TARGET_OS_OSX
- (void)didChangeText
{
	[super didChangeText];
	[self onTextChange];
}
#endif
- (void)onTextChange
{
#if TARGET_OS_IOS
	self.currentEditingDocument.markdownString = self.text;
#elif TARGET_OS_OSX
#endif
}
@end
