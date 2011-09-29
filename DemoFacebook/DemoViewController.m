//
//  DemoViewController.m
//  DemoFacebook
//
//  Created by Vivian Aranha on 5/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "DemoViewController.h"
#import "FriendsViewController.h"
#import "FeedViewController.h"

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
		
		if (token == nil) {
			userLogged = NO;
		} else {
            userLogged = YES;
        }
        
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

-(void) loginToFacebook{
    [[FacebookHelper sharedFacebookHelper] loginUserWithDelegate:self];
}

-(void) getUserDetails{
    [[FacebookHelper sharedFacebookHelper] detailsOfUserWithDelegate:self];
}

-(void) showFriends{
    [[FacebookHelper sharedFacebookHelper] friendsofUserWithDelegate:self];
}

-(void) logout{
    [[FacebookHelper sharedFacebookHelper] logoutUserWithDelegate:self];
}

-(void) showMyFeed{
    [[FacebookHelper sharedFacebookHelper] showUserFeedWithDelegate:self];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    friendsBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    friendsBtn.frame = CGRectMake(10, 300, 300, 30);
    [friendsBtn setTitle:@"My Friends" forState:UIControlStateNormal];
    [friendsBtn addTarget:self action:@selector(showFriends) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:friendsBtn];

    
    logoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logoutBtn.frame = CGRectMake(10, 340, 300, 30);
    [logoutBtn setTitle:@"LogOut" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(10, 10, 300, 30);
    [loginBtn setTitle:@"Login to Facebook" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginToFacebook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    myFeedBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myFeedBtn.frame = CGRectMake(10, 260, 300, 30);
    [myFeedBtn setTitle:@"My Feed" forState:UIControlStateNormal];
    [myFeedBtn addTarget:self action:@selector(showMyFeed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myFeedBtn]; 
    
    
    if(!userLogged){
        loginBtn.hidden = NO;
        myFeedBtn.hidden = YES;
        friendsBtn.hidden = YES;
        logoutBtn.hidden = YES;
    } else {
        [self getUserDetails];
        loginBtn.hidden = YES;
        myFeedBtn.hidden = NO;
        friendsBtn.hidden = NO;
        logoutBtn.hidden = NO;
    }
    
        
    
    
    
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

- (void) failedToLogin:(FacebookHelper*) helper{
    NSLog(@"Failed Login");    
    
}

- (void) finishedWithRequest:(FacebookHelper*) helper andResult:(NSDictionary*)dict{
   // NSLog(@"Reques FInished - %@",dict);
    
    lblEmail = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 30)];
    lblEmail.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"email"]];
    [self.view addSubview:lblEmail];

    
}

- (void) finishedWithFriendsRequest:(FacebookHelper*) helper andResult:(NSDictionary*)dict{
    
    FriendsViewController *friendsController = [[FriendsViewController alloc] init];
    [self.navigationController pushViewController:friendsController animated:YES];
    friendsController.friendsDictionary = dict;
    friendsController.title = @"My Friends";
    [friendsController release];
    
}

- (void) userLoggedIn:(FacebookHelper*) helper{
    
    NSLog(@"User Logged In");
    loginBtn.hidden = YES;
    myFeedBtn.hidden = NO;
    friendsBtn.hidden = NO;
    logoutBtn.hidden = NO;
    [self getUserDetails];

}

- (void) userLoggedOut:(FacebookHelper*) helper{
    
    NSLog(@"User Logged Out");
    loginBtn.hidden = NO;
    myFeedBtn.hidden = YES;
    friendsBtn.hidden = YES;
    logoutBtn.hidden = YES;
    lblEmail.text = @"";
}

- (void) drawUserFeed:(FacebookHelper*) helper andResult:(NSDictionary*)dict{
    
    //NSLog(@"FEED - %@",dict);
    
    FeedViewController *myFeed = [[FeedViewController alloc] init];
    myFeed.feedArray = [dict objectForKey:@"data"];
    myFeed.title = @"My Feed";
    [self.navigationController pushViewController:myFeed animated:YES];
    [myFeed release];
    
}

@end
