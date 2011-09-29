//
//  FacebookHelper.m
//  DemoFacebook
//
//  Created by Vivian Aranha on 5/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "FacebookHelper.h"

static FacebookHelper *sharedFacebookHelper = nil;

@implementation FacebookHelper

@synthesize facebook, delegate, requestType;

+ (id) sharedFacebookHelper{
    if (!sharedFacebookHelper)
		sharedFacebookHelper = [[FacebookHelper alloc] init];
	
	return sharedFacebookHelper;
}

- (void) loginUserWithDelegate:(id) _delegate{
    self.delegate = _delegate;
    facebook = [[Facebook alloc] initWithAppId:FB_APP_ID];
    
    NSArray* permissions =  [[NSArray arrayWithObjects:@"email", @"read_stream",@"offline_access",@"publish_stream", nil] retain];
    [facebook authorize:permissions delegate:self];

    
}

-(void) logoutUserWithDelegate:(id) _delegate{
    self.delegate = _delegate;
    if(facebook != nil){
        [facebook logout:self];
    }
    
}

-(void) detailsOfUserWithDelegate:(id) _delegate{
    requestType = FBRequestTypeSelf;
    self.delegate = _delegate;
    if(facebook == nil){
        facebook = [[Facebook alloc] initWithAppId:FB_APP_ID];
        facebook.accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"];
        facebook.expirationDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:@"exp_date"];
        facebook.sessionDelegate = self;
 
    }
    [facebook requestWithGraphPath:@"me" andDelegate: self];
}

-(void) friendsofUserWithDelegate:(id) _delegate{
    requestType = FBRequestTypeFriends;
    self.delegate = _delegate;
    if(facebook == nil){
        facebook = [[Facebook alloc] initWithAppId:FB_APP_ID];
        facebook.accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"];
        facebook.expirationDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:@"exp_date"];
        facebook.sessionDelegate = self;
        
    }
    [facebook requestWithGraphPath:@"me/friends" andDelegate: self];
    
}

-(void) postOnWallWithDelegate:(id) _delegate andID:(NSString *)friendID{
    requestType = FBRequestTypePostOnFriends;
    self.delegate = _delegate;
    if(facebook == nil){
        facebook = [[Facebook alloc] initWithAppId:FB_APP_ID];
        facebook.accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"];
        facebook.expirationDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:@"exp_date"];
        facebook.sessionDelegate = self;
        
    }
    
    NSString *postString = @"You have been slapped by Vivian Aranha, Check http://www.vivianaranha.com";
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   postString,@"message",
                                   @"Test it!",@"name",                                   
                                   nil];
    
     NSString *str = [NSString stringWithFormat:@"%@/feed",friendID];

    
    //[facebook dialog:str andParams:params andDelegate:self];
    
    
    [facebook requestWithGraphPath:str 
                          andParams:params
                      andHttpMethod:@"POST"
                        andDelegate:self];
    /*
    NSString *str = [NSString stringWithFormat:@"%@/feed",friendID];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Share on Facebook",  @"user_message_prompt",
                                   actionLinksStr, @"action_links",
                                   attachmentStr, @"attachment",
                                   nil];
    
    [facebook dialog:str andParams:params andDelegate:self];
     
    
    [facebook requestWithGraphPath:str
                         andParams:[NSMutableDictionary dictionaryWithObject:@"Testing Facebook SDK" forKey:@"message"]
                     andHttpMethod:@"POST"
                       andDelegate:self];
     */
}

-(void) showUserFeedWithDelegate:(id) _delegate{
    requestType = FBRequestTypeUserFeed;
    self.delegate = _delegate;
    if(facebook == nil){
        facebook = [[Facebook alloc] initWithAppId:FB_APP_ID];
        facebook.accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"];
        facebook.expirationDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:@"exp_date"];
        facebook.sessionDelegate = self;
        
    }

    [facebook requestWithGraphPath:@"me/feed" andDelegate: self];

       
}

-(void) showFriendFeedWithDelegate:(id) _delegate andID:(NSString *)friendID{
    requestType = FBRequestTypeFriendFeed;
    self.delegate = _delegate;
    if(facebook == nil){
        facebook = [[Facebook alloc] initWithAppId:FB_APP_ID];
        facebook.accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"];
        facebook.expirationDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:@"exp_date"];
        facebook.sessionDelegate = self;
        
    }
    
    NSString *str = [NSString stringWithFormat:@"%@/feed",friendID];
    [facebook requestWithGraphPath:str andDelegate: self];
    
    
}


#pragma mark -
#pragma mark FacebookSessionDelegate

- (void)fbDidLogin {	
	[[NSUserDefaults standardUserDefaults] setObject:facebook.accessToken forKey:@"access_token"];
	[[NSUserDefaults standardUserDefaults] setObject:facebook.expirationDate forKey:@"exp_date"];
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"User Logged In");
    
    if ([self.delegate respondsToSelector:@selector(userLoggedIn:)])
		[self.delegate userLoggedIn:self];
}


- (void)fbDidNotLogin:(BOOL)cancelled {

}

- (void)fbDidLogout {
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"access_token"];
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"exp_date"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
    if ([self.delegate respondsToSelector:@selector(userLoggedOut:)])
		[self.delegate userLoggedOut:self];
}



#pragma mark -
#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
    NSLog(@"ResponseFailed: %@", error);
	
	if ([self.delegate respondsToSelector:@selector(failedToLogin:)])
		[self.delegate failedToLogin:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	//NSLog(@"Parsed Response: %@", result);
	
    if(requestType == FBRequestTypeSelf){
        if ([self.delegate respondsToSelector:@selector(finishedWithRequest:andResult:)]){
            [self.delegate finishedWithRequest:self andResult:result];
        }
    }
    
    if(requestType == FBRequestTypeFriends){
        if ([self.delegate respondsToSelector:@selector(finishedWithFriendsRequest:andResult:)]){
            [self.delegate finishedWithFriendsRequest:self andResult:result];
        }
    }
    
    if(requestType == FBRequestTypePostOnFriends){
        NSLog(@"POSTED ON FRIENDS WALL");
    }
    
    if(requestType == FBRequestTypeUserFeed){
        if ([self.delegate respondsToSelector:@selector(drawUserFeed:andResult:)]){
            [self.delegate drawUserFeed:self andResult:result];
        }
        
    }
    
    if(requestType == FBRequestTypeFriendFeed){
        if ([self.delegate respondsToSelector:@selector(drawFriendFeed:andResult:)]){
            [self.delegate drawFriendFeed:self andResult:result];
        }
    }
    
}


@end
