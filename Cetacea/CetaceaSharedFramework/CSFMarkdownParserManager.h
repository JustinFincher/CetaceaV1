//
//  CSFMarkdownParserManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
#import "TSBaseParser.h"

@interface CSFMarkdownParserManager : NSObject

@property (nonatomic,strong) TSBaseParser *lineParser;
@property (nonatomic,strong) TSBaseParser *paragraphParser;
@property (nonatomic,strong) TSBaseParser *fullParser;

+ (id)sharedManager;


@end
