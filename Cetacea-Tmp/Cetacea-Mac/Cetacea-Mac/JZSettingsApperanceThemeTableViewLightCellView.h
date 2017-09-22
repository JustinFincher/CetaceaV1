//
//  JZSettingsApperanceThemeTableViewLightCellView.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/9.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MKColorWell.h"

@interface JZSettingsApperanceThemeTableViewLightCellView : NSTableCellView

@property (weak) IBOutlet MKColorWell *foregroundTextColorWell;
@property (weak) IBOutlet MKColorWell *foregroundTagColorWell;
@property (weak) IBOutlet MKColorWell *backgroundBlockColorWell;


@end
