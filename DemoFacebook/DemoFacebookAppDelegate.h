//
//  DemoFacebookAppDelegate.h
//  DemoFacebook
//
//  Created by Vivian Aranha on 5/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoViewController.h"

@interface DemoFacebookAppDelegate : NSObject <UIApplicationDelegate> {
    DemoViewController *demoVc;
}

@property (nonatomic, retain) DemoViewController *demoVc;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
