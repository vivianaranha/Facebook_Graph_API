//
//  FriendsDetailViewController.h
//  DemoFacebook
//
//  Created by Vivian Aranha on 5/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookHelper.h"


@interface FriendsDetailViewController : UIViewController <FBHelperDelegate> {
    NSString *friendsName;
    NSString *friendsID;
}

@property(nonatomic, retain) NSString *friendsName;
@property(nonatomic, retain) NSString *friendsID;


@end
