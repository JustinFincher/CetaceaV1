//
//  JZTraitCollectionManager.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/11.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZTraitCollectionManager.h"

@implementation JZTraitCollectionManager

+ (JZTraitCollectionLayoutStyle)currentHorizonalTraitCollection
{
    return [[[[UIApplication sharedApplication] windows] firstObject] bounds].size.width > 568.0f ? JZTraitCollectionLayoutStyleRegular : JZTraitCollectionLayoutStyleCompact;
}

+ (JZTraitCollectionLayoutStyle)horizonalTraitCollectionWithValue:(CGFloat)value
{
    return value > 568.0f ? JZTraitCollectionLayoutStyleRegular : JZTraitCollectionLayoutStyleCompact;

}
+ (BOOL)isHorizonalCompact
{
    return [JZTraitCollectionManager currentHorizonalTraitCollection] == JZTraitCollectionLayoutStyleCompact;
}
@end
