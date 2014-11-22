//
//  UserFavourites.h
//  SportsSub
//
//  Created by Kalyan Varma on 19/11/14.
//  Copyright (c) 2014 Kalyan Varma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserFavourites : NSManagedObject

@property (nonatomic, retain) NSNumber * favouriteId;
@property (nonatomic, retain) NSNumber * favouriteUserId;
@property (nonatomic, retain) NSString * favouriteUserImage;
@property (nonatomic, retain) NSString * favouriteUserThumbImage;
@property (nonatomic, retain) NSString * favouriteUserFirstname;
@property (nonatomic, retain) NSString * favouriteUserLastname;
@property (nonatomic, retain) NSString * favouriteUserEmailId;
@property (nonatomic, retain) NSString * favouriteUserGender;
@property (nonatomic, retain) NSDate * favouriteUserDOB;

@end
