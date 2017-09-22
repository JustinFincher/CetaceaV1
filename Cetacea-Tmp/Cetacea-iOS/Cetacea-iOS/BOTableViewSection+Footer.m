//
//  BOTableViewSection+Footer.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/14.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "BOTableViewSection+Footer.h"

@implementation  BOTableViewSection (Footer)

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle FooterTitle:(NSString *)footerTitle handler:(void (^)(BOTableViewSection *section))handler
{
    BOTableViewSection *section = [self sectionWithHeaderTitle:headerTitle handler:handler];
    section.footerTitle = footerTitle;
    return section;
}

@end
