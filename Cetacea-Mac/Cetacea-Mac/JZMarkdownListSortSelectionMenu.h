//
//  JZMarkdownListSortSelectionMenu.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/8/14.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, JZMarkdownListSortMethod)
{
    JZMarkdownListSortMethodByEditDate,
    JZMarkdownListSortMethodByCreateDate,
    JZMarkdownListSortMethodByTitle,
};
typedef NS_ENUM(NSUInteger, JZMarkdownListSortDirection)
{
    JZMarkdownListSortDirectionAscending,
    JZMarkdownListSortDirectionDescending,
};

@protocol JZMarkdownListSortSelectionMenuDelegate;

@interface JZMarkdownListSortSelectionMenu : NSMenu
@property (nonatomic, assign) id <JZMarkdownListSortSelectionMenuDelegate> sortResultDelegate;
@property (nonatomic,strong) NSMenuItem *byEditDateItem;
@property (nonatomic,strong) NSMenuItem *byCreateDateItem;
@property (nonatomic,strong) NSMenuItem *byTitleItem;
@property (nonatomic,strong) NSMenuItem *byAscending;
@property (nonatomic,strong) NSMenuItem *byDescending;

@property (nonatomic) JZMarkdownListSortMethod sortMethod;
@property (nonatomic) JZMarkdownListSortDirection sortDirection;

- (id)initWithSortMethod:(JZMarkdownListSortMethod)method
           SortDirection:(JZMarkdownListSortDirection)direction;

@end

@protocol JZMarkdownListSortSelectionMenuDelegate <NSObject>
@optional

- (void)selectionChanged;

@end
