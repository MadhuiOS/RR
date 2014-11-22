//
//  UserProfile.h
//  SportsSub
//
//  Created by Kalyan Varma on 01/11/14.
//  Copyright (c) 2014 Kalyan Varma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserProfile : NSManagedObject

@property (nonatomic, retain) NSString * userDOB;
@property (nonatomic, retain) NSString * userEmail;
@property (nonatomic, retain) NSString * userFacebookId;
@property (nonatomic, retain) NSString * userFirstName;
@property (nonatomic, retain) NSString * userGender;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userImage;
@property (nonatomic, retain) NSString * userLastName;
@property (nonatomic, retain) NSString * userLatitude;
@property (nonatomic, retain) NSString * userLongitude;
@property (nonatomic, retain) NSString * userThumbImage;
@property (nonatomic, retain) NSString * userTwitterId;

@end
