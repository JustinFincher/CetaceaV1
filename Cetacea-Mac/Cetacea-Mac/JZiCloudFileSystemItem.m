//
//  JZiCloudFileSystemItem.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/5.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZiCloudFileSystemItem.h"

@implementation JZiCloudFileSystemItem
@synthesize relativePath,parent,children,childrenFolderOnly,childrenMDOnly;

static JZiCloudFileSystemItem *rootItem = nil;
static NSMutableArray *leafNode = nil;

+ (void)initialize {
    if (self == [JZiCloudFileSystemItem class])
    {
        leafNode = [[NSMutableArray alloc] init];
    }
}

- (id)initWithPath:(NSString *)path parent:(JZiCloudFileSystemItem *)parentItem {
    self = [super init];
    if (self) {
        relativePath = [[path lastPathComponent] copy];
        parent = parentItem;
    }
    return self;
}
- (void)refresh
{
    rootItem = nil;
}

+ (JZiCloudFileSystemItem *)rootItem {
    if (rootItem == nil)
    {
        NSString *icloudRoot = [[[JZiCloudStorageManager sharedManager] ubiquitousDocumentsURL] path];
        rootItem = [[JZiCloudFileSystemItem alloc] initWithPath:icloudRoot parent:nil];
    }
    return rootItem;
}


// Creates, caches, and returns the array of children
// Loads children incrementally
- (NSArray *)children {
    
    if (children == nil)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *fullPath = [self fullPath];
        BOOL isDir, valid;
        
        valid = [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
        
        if (valid && isDir) {
            NSArray *array = [fileManager contentsOfDirectoryAtURL:[NSURL fileURLWithPath:fullPath isDirectory:YES]
                                        includingPropertiesForKeys:[NSArray arrayWithObject:NSURLNameKey]
                                                           options:NSDirectoryEnumerationSkipsHiddenFiles
                                                             error:nil];

            
            NSUInteger numChildren, i;
            
            numChildren = [array count];
            children = [[NSMutableArray alloc] initWithCapacity:numChildren];
            
            for (i = 0; i < numChildren; i++)
            {
                JZiCloudFileSystemItem *newChild = [[JZiCloudFileSystemItem alloc]
                                            initWithPath:[[array objectAtIndex:i] path] parent:self];
                [children addObject:newChild];
            }
        }
        else {
            children = leafNode;
        }
    }
    return children;
}
- (NSArray *)childrenFolderOnly
{
    
    if (childrenFolderOnly == nil)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *fullPath = [self fullPath];
        BOOL isDir, valid;
        
        valid = [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
        
        if (valid && isDir) {
            NSArray *array = [fileManager contentsOfDirectoryAtURL:[NSURL fileURLWithPath:fullPath isDirectory:YES]
                                        includingPropertiesForKeys:[NSArray arrayWithObject:NSURLNameKey]
                                                           options:NSDirectoryEnumerationSkipsHiddenFiles
                                                             error:nil];
            
            
            NSUInteger numChildren, i;
            
            numChildren = [array count];
            childrenFolderOnly = [[NSMutableArray alloc] initWithCapacity:numChildren];
            
            for (i = 0; i < numChildren; i++)
            {
                BOOL isDirectory;
                BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:[[array objectAtIndex:i] path] isDirectory:&isDirectory];
                if (isDirectory && fileExistsAtPath)
                {
                    JZiCloudFileSystemItem *newChild = [[JZiCloudFileSystemItem alloc]
                                                        initWithPath:[[array objectAtIndex:i] path] parent:self];
                    [childrenFolderOnly addObject:newChild];
                }
            }
        }
        else {
            childrenFolderOnly = leafNode;
        }
    }
    return childrenFolderOnly;
}

- (NSArray *)childrenMDOnly
{
    if (childrenMDOnly == nil)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *fullPath = [self fullPath];
        BOOL isDir, valid;
        
        valid = [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
        
        if (valid && isDir) {
            NSArray *array = [fileManager contentsOfDirectoryAtURL:[NSURL fileURLWithPath:fullPath isDirectory:YES]
                                        includingPropertiesForKeys:[NSArray arrayWithObject:NSURLNameKey]
                                                           options:NSDirectoryEnumerationSkipsHiddenFiles
                                                             error:nil];
            
            
            NSUInteger numChildren, i;
            
            numChildren = [array count];
            childrenFolderOnly = [[NSMutableArray alloc] initWithCapacity:numChildren];
            
            for (i = 0; i < numChildren; i++)
            {
                BOOL isDirectory;
                BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:[[array objectAtIndex:i] path] isDirectory:&isDirectory];
                BOOL isMarkdown = ([[[array objectAtIndex:i] pathExtension] compare: @"jpg"] == NSOrderedSame);
                if (fileExistsAtPath & isMarkdown)
                {
                    JZiCloudFileSystemItem *newChild = [[JZiCloudFileSystemItem alloc]
                                                        initWithPath:[[array objectAtIndex:i] path] parent:self];
                    [childrenMDOnly addObject:newChild];
                }
            }
        }
        else {
            childrenMDOnly = leafNode;
        }
    }
    return childrenMDOnly;
}
- (NSString *)relativePath {
    return relativePath;
}


- (NSString *)fullPath {
    // If no parent, return our own relative path
    if (parent == nil)
    {
        return [[[JZiCloudStorageManager sharedManager] ubiquitousDocumentsURL] path];
    }
    
    // recurse up the hierarchy, prepending each parent’s path
    return [[parent fullPath] stringByAppendingPathComponent:relativePath];
}


- (JZiCloudFileSystemItem *)childAtIndex:(NSUInteger)n {
    return [[self children] objectAtIndex:n];
}
- (JZiCloudFileSystemItem *)childFolderAtIndex:(NSUInteger)n
{
    return [[self childrenFolderOnly] objectAtIndex:n];
}

- (NSInteger)numberOfChildren
{
    NSArray *tmp = [self children];
    return (tmp == leafNode) ? (-1) : [tmp count];
}
- (NSInteger)numberOfChildrenMD
{
    NSArray *tmp = [self childrenMDOnly];
    return (tmp == leafNode) ? (-1) : [tmp count];
}
- (NSInteger)numberOfChildrenFolder
{
    NSArray *tmp = [self childrenFolderOnly];
    return (tmp == leafNode) ? (-1) : [tmp count];
}


@end
