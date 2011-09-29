//
//  DemoFacebookAppDelegate.m
//  DemoFacebook
//
//  Created by Vivian Aranha on 5/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "DemoFacebookAppDelegate.h"
#import "FacebookHelper.h"

@implementation DemoFacebookAppDelegate


@synthesize window=_window;
@synthesize demoVc;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    demoVc = [[DemoViewController alloc] init];
    demoVc.title = @"Facebook Demo";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:demoVc];
    
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"I AM Called");
    
    return [[[FacebookHelper sharedFacebookHelper] facebook] handleOpenURL:url];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
