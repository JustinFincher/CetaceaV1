//
//  CSFMarkdownParserManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
#import "TSBaseParser.h"
#import "CSFCetaceaThemeSharedDocument.h"

@interface CSFMarkdownParserManager : NSObject

@property (nonatomic,strong) TSBaseParser *lineParser;
@property (nonatomic,strong) TSBaseParser *paragraphParser;
@property (nonatomic,strong) TSBaseParser *fullParser;

@property (nonatomic) BOOL shouldRemoveTags;

@property (nonatomic, weak) CSFCetaceaThemeAbstractSharedDocument *themeDoc;

@property (nonatomic, strong) NSDictionary<NSString *, id> *defaultAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *atxHeaderTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *atxHeaderTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *setextHeaderTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *setextHeaderTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *codeBlockTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *codeBlockTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *boldTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *boldTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *italicTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *italicTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *strikeThroughTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *strikeThroughTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *tabIndentTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *tabIndentTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *listTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *listTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *quoteTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *quoteTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *imageTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *imageTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *linkTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *linkTagAttributes;

+ (id)sharedManager;
- (void)refreshAttributesTheme;
- (NSAttributedString *)attributedParagraphParserStringFromMarkdown:(NSString *)markdown;
- (NSAttributedString *)attributedLineParserStringFromMarkdown:(NSString *)markdown;
- (NSAttributedString *)attributedStringFromMarkdown:(NSString *)markdown;


@end
