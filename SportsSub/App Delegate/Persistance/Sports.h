//
//  Sports.h
//  SportsSub
//
//  Created by Kalyan Varma on 01/11/14.
//  Copyright (c) 2014 Kalyan Varma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Sports : NSManagedObject

@property (nonatomic, retain) NSString * sportsId;
@property (nonatomic, retain) NSString * sportsName;

@end
