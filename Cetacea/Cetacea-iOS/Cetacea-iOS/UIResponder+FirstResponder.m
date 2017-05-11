//
//  UIViewHelper.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/11.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "UIResponder+FirstResponder.h"
static __weak id currentFirstResponder;
@implementation UIResponder (FirstResponder)
+(id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}
-(void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}
@end
