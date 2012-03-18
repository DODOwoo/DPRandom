//
//  DPRandomAppDelegate.h
//  DPRandom
//
//  Created by DODOwoo on 12-3-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPRandomViewController;

@interface DPRandomAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DPRandomViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DPRandomViewController *viewController;

@end

