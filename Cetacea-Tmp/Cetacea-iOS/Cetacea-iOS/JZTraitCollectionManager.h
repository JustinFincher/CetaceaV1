//
//  JZTraitCollectionManager.h
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/11.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JZTraitCollectionLayoutStyle)
{
    JZTraitCollectionLayoutStyleCompact,
    JZTraitCollectionLayoutStyleRegular
};

@interface JZTraitCollectionManager : NSObject

+ (JZTraitCollectionLayoutStyle)currentHorizonalTraitCollection;
+ (JZTraitCollectionLayoutStyle)horizonalTraitCollectionWithValue:(CGFloat)value;
+ (BOOL)isHorizonalCompact;

@end
