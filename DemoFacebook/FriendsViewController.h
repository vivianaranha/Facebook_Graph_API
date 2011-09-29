//
//  FriendsViewController.h
//  DemoFacebook
//
//  Created by Vivian Aranha on 5/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FriendsViewController : UITableViewController {
    NSDictionary *friendsDictionary;
}

@property(nonatomic, retain) NSDictionary *friendsDictionary;

@end
