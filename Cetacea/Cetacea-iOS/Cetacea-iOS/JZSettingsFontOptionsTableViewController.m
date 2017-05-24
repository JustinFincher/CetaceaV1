//
//  JZSettingsFontOptionsTableViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/24.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZSettingsFontOptionsTableViewController.h"

@interface JZSettingsFontOptionsTableViewController ()

@end

@implementation JZSettingsFontOptionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"Choice Font";
	
	
	[self addSection:[BOTableViewSection sectionWithHeaderTitle:nil handler:^(BOTableViewSection *section)
	{
		for (NSString *name in [[CSFEditorTextFontManager sharedManager] getCanBeSelectedFontInApp])
		{
			[section addCell:[BOOptionTableViewCell cellWithTitle:name key:@"com.JustZht.Cetacea.Settings.Editor.BaseFont.Name" handler:^(BOOptionTableViewCell *cell) {
				cell.footerTitle = name;
				cell.mainFont = [UIFont fontWithName:name size:[UIFont systemFontSize]];
			}]];
		}
	}]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
