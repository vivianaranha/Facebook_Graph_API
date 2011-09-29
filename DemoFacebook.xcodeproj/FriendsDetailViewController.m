//
//  FriendsDetailViewController.m
//  DemoFacebook
//
//  Created by Vivian Aranha on 5/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "FriendsDetailViewController.h"
#import "FeedViewController.h"

@implementation FriendsDetailViewController

@synthesize friendsName, friendsID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(void)postOnWall{
    
    [[FacebookHelper sharedFacebookHelper] postOnWallWithDelegate:self andID:friendsID];
    
}

-(void) showNewsFeed{
    [[FacebookHelper sharedFacebookHelper] showFriendFeedWithDelegate:self andID:friendsID];
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *lblFriendsName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    lblFriendsName.text = friendsName;
    [self.view addSubview:lblFriendsName];
    [lblFriendsName release];
    
    /*
    
    UILabel *lblFriendsID = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 30)];
    lblFriendsID.text = friendsID;
    [self.view addSubview:lblFriendsID];
    [lblFriendsID release];
    */
    
    UIButton *btnPost = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnPost.frame = CGRectMake(10, 60, 300, 30);
    [btnPost setTitle:@"Post" forState:UIControlStateNormal];
    [btnPost addTarget:self action:@selector(postOnWall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPost];
    
    UIButton *btnFeed = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnFeed.frame = CGRectMake(10, 100, 300, 30);
    [btnFeed setTitle:@"News Feed" forState:UIControlStateNormal];
    [btnFeed addTarget:self action:@selector(showNewsFeed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFeed];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) drawFriendFeed:(FacebookHelper*) helper andResult:(NSDictionary*)dict{
    
    FeedViewController *friendFeed = [[FeedViewController alloc] init];
    friendFeed.feedArray = [dict objectForKey:@"data"];
    friendFeed.title = @"My Feed";
    [self.navigationController pushViewController:friendFeed animated:YES];
    [friendFeed release];
    
    
}

@end
