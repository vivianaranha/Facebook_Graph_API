//
//  DemoViewController.h
//  DemoFacebook
//
//  Created by Vivian Aranha on 5/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookHelper.h"


@interface DemoViewController : UIViewController <FBHelperDelegate>{
    UIButton *loginBtn;
    UIButton *friendsBtn;
    UIButton *logoutBtn;
    UIButton *myFeedBtn;
    BOOL *userLogged;
    
    UILabel *lblEmail;
}

@end
