//
//  UserReceivedInvitation.h
//  SportsSub
//
//  Created by Kalyan Varma on 19/11/14.
//  Copyright (c) 2014 Kalyan Varma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserReceivedInvitation : NSManagedObject

@property (nonatomic, retain) NSString * fromFirstname;
@property (nonatomic, retain) NSString * fromLastname;
@property (nonatomic, retain) NSNumber * inviteAccepted;
@property (nonatomic, retain) NSDate * inviteCreatedOn;
@property (nonatomic, retain) NSNumber * inviteDeleted;
@property (nonatomic, retain) NSNumber * inviteId;
@property (nonatomic, retain) NSString * inviteInstruction;
@property (nonatomic, retain) NSNumber * inviteLatitude;
@property (nonatomic, retain) NSNumber * inviteLongitude;
@property (nonatomic, retain) NSDate * inviteModifiedOn;
@property (nonatomic, retain) NSNumber * inviteRejected;
@property (nonatomic, retain) NSDate * inviteWhen;
@property (nonatomic, retain) NSString * inviteWhere;
@property (nonatomic, retain) NSString * sportName;
@property (nonatomic, retain) NSString * userimageurl;
@property (nonatomic, retain) NSString * userthumbimageurl;

@end
