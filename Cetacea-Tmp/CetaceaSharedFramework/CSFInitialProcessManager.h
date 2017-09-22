//
//  CSFInitialProcessManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/5.
//
//

#import <Foundation/Foundation.h>


/**
 Manager for launch processes. Add all needed init call in this
 */
@interface CSFInitialProcessManager : NSObject

+ (id)sharedManager;

/**
 Intial Process with all needed init calls called. Add this in [Application finishedlaunching];
 */
- (void)initialProcess;
@end
