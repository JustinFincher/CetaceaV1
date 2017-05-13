//
//  BOTableViewSection+Footer.h
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/14.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bohr/Bohr.h>
#import <Bohr/BOTableViewSection.h>

@interface BOTableViewSection (Footer)

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle FooterTitle:(NSString *)footerTitle handler:(void (^)(BOTableViewSection *section))handler;

@end
