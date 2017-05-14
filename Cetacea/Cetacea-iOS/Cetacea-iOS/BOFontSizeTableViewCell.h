//
//  BOFontSizeTableViewCell.h
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/14.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import <Bohr/Bohr.h>
#import "JZVerticalStepper.h"

@interface BOFontSizeTableViewCell : BOTableViewCell

@property (nonatomic) UIView *stepperContainerView;
@property (nonatomic) JZVerticalStepper *stepper;

@end
