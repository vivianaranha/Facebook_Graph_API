//
//  FacebookHelper.h
//  DemoFacebook
//
//  Created by Vivian Aranha on 5/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"

#define FB_APP_ID @"YOUR FACEBOOK ID"

@protocol FBHelperDelegate;

typedef enum {
    FBRequestTypeSelf = 0,
    FBRequestTypeFriends = 1,
    FBRequestTypePostOnFriends = 2,
    FBRequestTypeUserFeed = 3,
    FBRequestTypeFriendFeed = 4
} FBRequestType;


@interface FacebookHelper : NSObject <FBRequestDelegate, FBDialogDelegate, FBSessionDelegate>{
    Facebook *facebook;
    id <FBHelperDelegate> delegate;
    FBRequestType requestType;
}

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, assign) id <FBHelperDelegate> delegate;
@property (nonatomic, assign) FBRequestType requestType;

+(id) sharedFacebookHelper;
-(void) loginUserWithDelegate:(id) _delegate;
-(void) detailsOfUserWithDelegate:(id) _delegate;
-(void) friendsofUserWithDelegate:(id) _delegate;
-(void) postOnWallWithDelegate:(id) _delegate andID:(NSString *)friendID;
-(void) logoutUserWithDelegate:(id) _delegate;
-(void) showUserFeedWithDelegate:(id) _delegate;
-(void) showFriendFeedWithDelegate:(id) _delegate andID:(NSString *)friendID;


@end



@protocol FBHelperDelegate <NSObject>
@optional
- (void) failedToLogin:(FacebookHelper*) helper;
- (void) finishedWithRequest:(FacebookHelper*) helper andResult:(NSDictionary*)dict;
- (void) finishedWithFriendsRequest:(FacebookHelper*) helper andResult:(NSDictionary*)dict;
- (void) userLoggedIn:(FacebookHelper*) helper;
- (void) userLoggedOut:(FacebookHelper*) helper;
- (void) drawUserFeed:(FacebookHelper*) helper andResult:(NSDictionary*)dict;
- (void) drawFriendFeed:(FacebookHelper*) helper andResult:(NSDictionary*)dict;


@end

