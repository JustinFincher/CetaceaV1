//
//  CSFTextAttributes.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/19.
//
//

#import "CSFTextAttributes.h"

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#endif


static NSDictionary * CSFDefaultTextAttributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:12.0]};
#endif
}

static NSDictionary * CSFDefaultH1Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleLargeTitle]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:24.0]};
#endif
}

static NSDictionary * CSFDefaultH2Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:18.0]};
#endif
}

static NSDictionary * CSFDefaultH3Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:14.0]};
#endif
}

static NSDictionary * CSFDefaultH4Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:12.0]};
#endif
}

static NSDictionary * CSFDefaultH5Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:10.0]};
#endif
}

static NSDictionary * CSFDefaultH6Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:8.0]};
#endif
}

static NSDictionary * CSFDefaultLinkAttributes()
{
    return @{
#if TARGET_OS_IPHONE
             NSForegroundColorAttributeName: UIColor.blueColor,
#else
             NSForegroundColorAttributeName: NSColor.blueColor,
#endif
             NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)
             };
}

#if TARGET_OS_IPHONE
static UIFont * MonospaceFont()
{
    CGFloat size = [[UIFont preferredFontForTextStyle:UIFontTextStyleBody] pointSize];
    return [UIFont fontWithName:@"Menlo" size:size] ?: [UIFont fontWithName:@"Courier" size:size];
}
#endif

static NSParagraphStyle * DefaultIndentedParagraphStyle()
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = 30;
    style.headIndent = 30;
    return style;
}

static NSDictionary * CSFDefaultCodeBlockAttributes()
{
    return @{
#if TARGET_OS_IPHONE
             NSFontAttributeName: MonospaceFont(),
#else
             NSFontAttributeName: [NSFont userFixedPitchFontOfSize:12.0],
#endif
             NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()
             };
}

static NSDictionary * CSFDefaultInlineCodeAttributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: MonospaceFont()};
#else
    return @{NSFontAttributeName: [NSFont userFixedPitchFontOfSize:12.0]};
#endif
}

static NSDictionary * CSFDefaultBlockQuoteAttributes()
{
    return @{NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()};
}

static NSDictionary * CSFDefaultOrderedListAttributes()
{
    return @{NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()};
}

static NSDictionary * CSFDefaultUnorderedListAttributes()
{
    return @{NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()};
}

static NSDictionary * CSFDefaultOrderedSublistAttributes()
{
    return @{NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()};
}

static NSDictionary * CSFDefaultUnorderedSublistAttributes()
{
    return @{NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()};
}

@implementation CSFTextAttributes

- (instancetype)init
{
    if ((self = [super init])) {
        _textAttributes = CSFDefaultTextAttributes();
        _h1Attributes = CSFDefaultH1Attributes();
        _h2Attributes = CSFDefaultH2Attributes();
        _h3Attributes = CSFDefaultH3Attributes();
        _h4Attributes = CSFDefaultH4Attributes();
        _h5Attributes = CSFDefaultH5Attributes();
        _h6Attributes = CSFDefaultH6Attributes();
        _linkAttributes = CSFDefaultLinkAttributes();
        _codeBlockAttributes = CSFDefaultCodeBlockAttributes();
        _inlineCodeAttributes = CSFDefaultInlineCodeAttributes();
        _blockQuoteAttributes = CSFDefaultBlockQuoteAttributes();
        _orderedListAttributes = CSFDefaultOrderedListAttributes();
        _unorderedListAttributes = CSFDefaultUnorderedListAttributes();
        _orderedSublistAttributes = CSFDefaultOrderedSublistAttributes();
        _unorderedSublistAttributes = CSFDefaultUnorderedSublistAttributes();
    }
    return self;
}

- (NSDictionary *)attributesForHeaderLevel:(NSInteger)level
{
    switch (level) {
        case 1: return _h1Attributes;
        case 2: return _h2Attributes;
        case 3: return _h3Attributes;
        case 4: return _h4Attributes;
        case 5: return _h5Attributes;
        default: return _h6Attributes;
    }
}

@end
