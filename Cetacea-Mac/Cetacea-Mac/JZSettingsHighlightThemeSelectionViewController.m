//
//  JZSettingsHighlightThemeSelectionViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZSettingsHighlightThemeSelectionViewController.h"
#import "JZiCloudFileExtensionCetaceaThemeDataBase.h"


@interface JZSettingsHighlightThemeSelectionViewController ()<NSCollectionViewDataSource,NSCollectionViewDelegate>
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSCollectionView *collectionView;

@property (strong,nonatomic) NSMutableArray *themeArray;

@property (strong,nonatomic) NSCollectionViewFlowLayout *flowLayout;

@end

@implementation JZSettingsHighlightThemeSelectionViewController
@synthesize flowLayout;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    [self configureCollectionView];
    [self reload];
}
- (void)reload
{
    self.themeArray = [[JZiCloudFileExtensionCetaceaThemeDataBase sharedManager] loadDocs];
    [self.collectionView reloadData];
}
- (void)configureCollectionView
{
    flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = NSMakeSize(240, 200);
    flowLayout.sectionInset = NSEdgeInsetsMake(10, 20, 10, 20);
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.minimumLineSpacing = 0.0f;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.allowsMultipleSelection = NO;
    self.collectionView.selectable = YES;
    
    self.view.wantsLayer = YES;
    self.collectionView.layer.backgroundColor = [NSColor clearColor].CGColor;
    self.collectionView.delegate = self;
}

#pragma mark - NSCollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(NSCollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    if (_themeArray)
    {
        return _themeArray.count;
    }
    return 0;
}
- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView
     itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    JZHighlighThemePreviewCollectionViewItem *item = [collectionView makeItemWithIdentifier:@"JZHighlighThemePreviewCollectionViewItem" forIndexPath:indexPath];
    BOOL isAddButton = NO;
    JZiCloudFileExtensionCetaceaThemeDoc *doc;
    NSString *themeName;
    NSColor *shadowColor;
    if (!isAddButton)
    {
        doc = [self.themeArray objectAtIndex:indexPath.item];
        themeName = doc.data.themeName;
        shadowColor = [doc.data.EditorViewDataModel.lightBackgroundBlockColor colorFromSelf];
        [item initWithisAddButton:isAddButton Theme:doc themeName:themeName];

    }
    return item;
}

#pragma mark - NSCollectionViewDelegate
- (void)collectionView:(NSCollectionView *)collectionView
didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths
{
    
    NSIndexPath *path = [indexPaths anyObject];
    if (path == nil)
    {
        return;
    }else
    {
        JZiCloudFileExtensionCetaceaThemeDoc *doc = [self.themeArray objectAtIndex:(path.item)];
        [self showThemeDoc:doc];
    }
}

#pragma mark - theme doc logic
- (void)createNewAndShow
{
    JZiCloudFileExtensionCetaceaThemeDoc *new = [[JZiCloudFileExtensionCetaceaThemeDoc alloc] initWithDocPath:[[JZiCloudFileExtensionCetaceaThemeDataBase sharedManager] nextDocPath]];
    //[new saveData];
    [self reload];
    [self showThemeDoc:new];
    
}
- (IBAction)addButtonPressed:(id)sender {
    [self createNewAndShow];
}
- (void)showThemeDoc:(JZiCloudFileExtensionCetaceaThemeDoc *)doc
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showiCloudFileExtensionCetaceaThemeDocEditPanel" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:doc,@"doc", nil]];
}


@end
