//
//  JZDocumentImportViewController.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/5/13.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "JZDocumentImportViewController.h"

@interface JZDocumentImportViewController ()
@property (weak, nonatomic) IBOutlet CSFEditorTextView *textView;

@end

@implementation JZDocumentImportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Import Cetacea Document";
    self.navigationController.toolbarHidden = NO;
    CSFiCloudFileExtensionCetaceaSharedDocument *document = [[CSFiCloudFileExtensionCetaceaSharedDocument alloc] initWithURL:self.importURL];
    self.textView.currentEditingDocument = document;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveButtonPressed:(id)sender
{
    NSURL *targetURL = [[CSFiCloudFileExtensionCetaceaDataBase sharedManager] nextFileURL];
    NSError *error;
    JZLog(@"importURL %@", [self.importURL path]);
    JZLog(@"targetURL %@", [targetURL path]);
    if (![[NSFileManager defaultManager] copyItemAtURL:self.importURL toURL:targetURL error:&error])
    {
        NSLog(@"Error %@", [error localizedDescription]);
    }
    [[NSFileManager defaultManager] removeItemAtURL:self.importURL error:nil];
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)deleteButtonPressed:(id)sender
{
    self.textView.currentEditingDocument = nil;
    [[NSFileManager defaultManager] removeItemAtURL:self.importURL error:nil];
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
